/*
 * pocket.js
 * Pocket API reference: http://getpocket.com/developer/docs/overview
 * Mozilla's pktApi reference: https://hg.mozilla.org/mozilla-central/file/tip/browser/extensions/pocket/content/pktApi.jsm
 *
 * (We duplicate some code, which is necessary, since Mozilla's pktApi is too restrictive for our use :( )
*/

let PLUGIN_INFO = xml`
<VimperatorPlugin>
    <name>pocket</name>
    <description lang="en">Pocket</description>
    <version>0.1.0</version>
    <minVersion>3.13.1</minVersion>
    <author homepage="www.github.com/oskarkook">Oskar Köök</author>
    <updateURL>https://raw.github.com/oskarkook/vimperator-pocket/master/pocket.js</updateURL>
</VimperatorPlugin>`;

(function() {
    let pktApi = (function() {
        let pocketAPIhost = Services.prefs.getCharPref("extensions.pocket.api");
        let pocketSiteHost = Services.prefs.getCharPref("extensions.pocket.site");
        let baseAPIUrl = "https://" + pocketAPIhost + "/v3";
        let oAuthConsumerKey = Services.prefs.getCharPref("extensions.pocket.oAuthConsumerKey");
        let baseReadUrl = "https://" + pocketSiteHost + "/a/read";

        let pktCache = storage.newMap("pocket", {store: true});

        function getCacheKeyOrSet(key, _default) {
            let val = pktCache.get(key);

            if(val === undefined) {
                val = _default;
                pktCache.set(key, _default);
                pktCache.save(key);
            }

            return val;
        }

        function getLinksCache() {
            return getCacheKeyOrSet("links", {});
        }

        function getPrefsCache() {
            return getCacheKeyOrSet("prefs", {lastUpdate: 0});
        }

        function getTagsCache() {
            return getCacheKeyOrSet("tags", {});
        }

        function getTimestamp() {
            return Math.round(Date.now() / 1000);
        }

        function getCookiesFromPocket() {
            let cookieManager = Cc["@mozilla.org/cookiemanager;1"].getService(Ci.nsICookieManager2);
            let pocketCookies = cookieManager.getCookiesFromHost(pocketSiteHost, {});
            let cookies = {};

            while (pocketCookies.hasMoreElements()) {
                let cookie = pocketCookies.getNext().QueryInterface(Ci.nsICookie2);
                cookies[cookie.name] = cookie.value;
            }
            return cookies;
        }

        function getAccessToken() {
            let cookies = getCookiesFromPocket();
            return cookies['ftv1'];
        }

        function apiRequest(path, data = {}, options = {}) {
            let url = baseAPIUrl + path;
            let request = Components.classes["@mozilla.org/xmlextras/xmlhttprequest;1"].createInstance(Components.interfaces.nsIXMLHttpRequest);
            data.consumer_key = oAuthConsumerKey;
            data.access_token = getAccessToken();

            request.open("POST", url, true);
            request.onreadystatechange = (e) => {
                if(request.readyState == 4) {
                    if(request.status == 200) {
                        let response = JSON.parse(request.response);
                        if(options.success && response && response.status == 1) {
                            options.success(response, request);
                            return;
                        }
                    } else if(options.error) {
                        let errorMsg = request.getResponseHeader("X-Error") || request.statusText;
                        errorMsg = JSON.parse('"' + errorMsg + '"');

                        options.error(errorMsg, request);
                    }
                }
            }

            request.setRequestHeader('Content-Type', 'application/json; charset=UTF-8');
            request.setRequestHeader('X-Accept',' application/json');

            let str = [];

            for(let p in data) {
                if(data.hasOwnProperty(p)) {
                    str.push(encodeURIComponent(p) + "=" + encodeURIComponent(data[p]));
                }
            }
            
            request.send(JSON.stringify(data));

            return true;
        }

        function apiRequestContext(path, data, options) {
            return {
                path,
                data,
                options,
                execute: () => apiRequest(path, data, options)
            }
        }

        function combineActions(...requestContexts) {
            let actions = [];

            let successF = null;
            let errorF = null;
            requestContexts.forEach((context) => {
                actions.push(context.data.actions[0]);

                if(context.options.success !== undefined) {
                    if(successF !== null) {
                        let oldSuccessF = successF;
                        successF = (response) => {
                            oldSuccessF(response);
                            context.options.success(response);
                        }
                    } else {
                        successF = context.options.success;
                    }
                }

                if(context.options.error !== undefined) {
                    if(errorF !== null) {
                        let oldErrorF = errorF;
                        errorF = (response) => {
                            oldErrorF(response);
                            context.options.error(response);
                        }
                    } else {
                        errorF = context.options.error;
                    }
                }
            });

            return apiRequestContext("/send", {actions}, {success: successF, error: errorF});
        }

        function update(since = getPrefsCache()["lastUpdated"], options) {
            getPrefsCache()["lastUpdated"] = getTimestamp();
            return apiRequest("/get", {
                since,
                detailType: "complete"
            }, {
                success: (response) => {
                    let responseFieldsToCache = ["item_id", "resolved_url", "given_title", ["tags", {}], "favorite", "status"];

                    for(let linkId in response.list) {
                        let fields = getFields(response.list[linkId], responseFieldsToCache);

                        if(fields["status"] !== "2") {
                            let tags = [];
                            for(let tag in fields["tags"]) {
                                tags.push(tag);
                            }

                            fields["tags"] = tags;

                            fieldsArr = Object.keys(fields).map(key => fields[key]);
                            addLinkToCache.apply(this, fieldsArr);
                        } else {
                            removeLinkFromCache(linkId);
                        }
                    }

                    pktCache.save();
                    if(options.success) {
                        options.success(response);
                    }
                }
            });
        }

        function removeLinkFromCache(id) {
            let linksCache = getLinksCache();
            let link = linksCache[id];

            delete linksCache[id];

            link.tags.forEach((tag) => {
                removeTagFromCache(id, tag);
            });
        }

        function addLinkToCache(id, url, title, tags, favorite, status) {
            getLinksCache()[id] = {
                url,
                title,
                tags,
                favorite,
                status
            };

            tags.forEach((tag) => {
                addTagToCache(id, tag);
            });
        }

        function getFields(jsonData, fieldsArr) {
            let result = {};
            fieldsArr.forEach((field) => {
                if(typeof field === "string") {
                    result[field] = jsonData[field];
                } else {
                    let resultVal = jsonData[field[0]];
                    if(resultVal !== undefined) {
                        result[field[0]] = resultVal;
                    } else {
                        result[field[0]] = field[1];
                    }
                }
            });

            return result;
        }

        function addLink(url, title, options = {}) {
            let data = {url, title};
            let extSuccessFunc = options.success;

            options.success = (response) => {
                let responseData = response.item;

                addLinkToCache(responseData["item_id"], responseData["resolved_url"], title, [], 0, 0);
                pktCache.save();

                if(extSuccessFunc !== undefined) {
                    extSuccessFunc(response);
                }
            }

            return apiRequest("/add", data, options);
        }

        function clearCache() {
            pktCache.clear();
            pktCache.save();
        }

        function removeLink(linkId, options) {
            let data = {
                actions: [
                    {
                        action: "delete",
                        item_id: linkId
                    }
                ]
            };

            let extSuccessFunc = options.success;

            options.success = (response) => {
                removeLinkFromCache(linkId);
                pktCache.save();

                if(extSuccessFunc !== undefined) {
                    extSuccessFunc(response);
                }
            }

            return apiRequest("/send", data, options)
        }

        function linkPocketUrl(linkId) {
            return baseReadUrl + "/" + linkId;
        }

        function removeTagFromCache(linkId, tag) {
            let tags = getTagsCache();

            let tagLinks = tags[tag];
            if(tagLinks !== undefined) {
                if(tagLinks.length === 1) {
                    delete tags[tag];
                } else {
                    let linkIndex = tagLinks.indexOf(linkId);
                    tagLinks.splice(linkIndex, 1);
                }
            }
        }

        function addTagToCache(linkId, tag) {
            let tags = getTagsCache();
            
            if(tags[tag] === undefined) {
                tags[tag] = [linkId];
            } else {
                tags[tag].push(linkId);
            } 
        }

        function removeTagFromLink(linkId, tag) {
            let tags = getLinksCache()[linkId].tags;
            let index = tags.indexOf(tag);

            if(index !== -1) {
                tags.splice(index, 1);
            }
        }

        function addTagToLink(linkId, tag) {
            let links = getLinksCache();
            links[linkId].tags.push(tag);
        }

        function addTag(linkId, tag, options = {}) {
            let data = {
                actions: [
                    {
                        action: "tags_add",
                        item_id: linkId,
                        tags: tag
                    }
                ]
            };

            let extSuccessFunc = options.success;
            options.success = (response) => {
                addTagToLink(linkId, tag);
                addTagToCache(linkId, tag);

                pktCache.save();
                if(extSuccessFunc !== undefined) {
                    extSuccessFunc(response);
                }
            }

            return apiRequestContext("/send", data, options);
        }

        function removeTag(linkId, tag, options = {}) {
            let data = {
                actions: [
                    {
                        action: "tags_remove",
                        item_id: linkId,
                        tags: tag
                    }
                ]
            };

            let extSuccessFunc = options.success;

            options.success = (response) => {
                removeTagFromLink(linkId, tag);
                removeTagFromCache(linkId, tag);

                pktCache.save();
                if(extSuccessFunc !== undefined) {
                    extSuccessFunc(response);
                }
            }

            return apiRequestContext("/send", data, options);
        }

        function clearTags(linkId) {
            let data = {
                actions: [
                    {
                        action: "tags_clear",
                        item_id: linkId
                    }
                ]
            }

            let extSuccessFunc = options.success;

            options.success = (response) => {
                let link = getLinksCache()[linkId];
                link.tags.forEach((tag) => {
                    removeTagFromCache(linkId, tag);
                });

                link.tags = [];

                pktCache.save();
                if(extSuccessFunc !== undefined) {
                    extSuccessFunc(response);
                }
            }

            return apiRequest("/send", data, options);
        }

        function renameTag(oldTag, newTag, options = {}) {
            let data = {
                actions: [
                    {
                        action: "tag_rename",
                        old_tag: oldTag,
                        new_tag: newTag
                    }
                ]
            }

            let extSuccessFunc = options.success;

            options.success = (response) => {
                let tags = getTagsCache();
                let links = getLinksCache();

                let linkIds = tags[oldTag];
                linkIds.forEach((linkId) => {
                    let link = links[linkId];
                    let tagIndex = link.tags.indexOf(oldTag);
                    link.tags[tagIndex] = newTag;
                });

                if(tags[newTag] === undefined) {
                    tags[newTag] = tags[oldTag];
                } else {
                    tags[oldTag].forEach((link) => {
                        if(tags[newTag].indexOf(link) === -1) {
                            tags[newTag].push(link);
                        }
                    });
                }

                delete tags[oldTag];

                pktCache.save();
                if(extSuccessFunc !== undefined) {
                    extSuccessFunc(response);
                }

            }

            return apiRequest("/send", data, options);
        }

        return {
            addLink,
            update,
            clearCache,
            linkPocketUrl,
            removeLink,
            addTag,
            removeTag,
            clearTags,
            combineActions,
            renameTag,
            getLinks: getLinksCache,
            getTags: getTagsCache
        }
    })();

    function echoMsg(message) {
        liberator.echomsg("Pocket: " + message);
    }

    function echoError(message) {
        liberator.echoerr("Pocket: " + message);
    }

    function addLink(url, title) {
        if (! (typeof url !== 'undefined' && (url.startsWith("http") || url.startsWith('https')))) {
            echoError("URL is not valid!");
            return;
        }

        if (url.startsWith("about:reader?url=")) {
            url = ReaderMode.getOriginalUrl(url);
        }

        pktApi.addLink(url, title, {
            success: () => {
                echoMsg("Link has been saved!");
            }
        });
    }

    function getLinkCompletions(args = {}) {
        let links = pktApi.getLinks();
        let completions = [];

        if(args["-tag"] !== undefined) {
            let tags = pktApi.getTags();
            let linkIds = tags[args["-tag"]];

            if(linkIds !== undefined) {
                let filteredLinks = {};

                linkIds.forEach((linkId) => {
                    filteredLinks[linkId] = links[linkId];
                });

                links = filteredLinks;

            }
        }

        for(let linkId in links) {
            let link = links[linkId];
            completions.push([linkId + ": " + link.title, link.url]);
        }

        return completions;
    }

    function getTagCompletions(showAll = false) {
        return (context, args) => {
            let completions = [];
            if(showAll) {
                let tags = pktApi.getTags();

                for(let tag in tags) {
                    completions.push([tag, ""]);
                }

                return completions;
            } else {
                let linkId = getLinkIdFromDescription(args["link"]);
                let tags = pktApi.getLinks()[linkId].tags;

                tags.forEach((tag) => {
                    completions.push([tag, ""]);
                });
            }
            return completions;
        }
    }

    function tagCompleter(context, args) {
        context.title = ["tag", ""];
        context.completions = getTagCompletions(true)();
    }

    function linkCompleter(context, args) {
        context.title = ["title", "url"];

        context.completions = getLinkCompletions(args);
    }

    function getLinkIdFromDescription(desc) {
        return parseInt(desc.split(":")[0]);
    }

    function openLink(args, mode) {
        let linkId = getLinkIdFromDescription(args[0]);
        let links = pktApi.getLinks();
        if(args["--pocketed"] !== undefined) {
            liberator.open(pktApi.linkPocketUrl(linkId), mode);
        } else {
            liberator.open(links[linkId].url, mode);
        }
    }

    const openOptions = [
        [["--pocketed"], commands.OPTION_NOARG],
        [["-tag"], commands.OPTION_STRING, null, getTagCompletions(true)],
        //[["-favorite"], commands.OPTION_NOARG],
        //[["-archived"], commands.OPTION_NOARG]
    ];

    const subCommands = [
            new Command(["add"], "Add a page to list", (args) => {
                let url = args["url"] || buffer.URL;
                let title = args["title"] || (url ? undefined : buffer.title);

                addLink(url, title);
            }, {
                literal: 0,
                options: [
                    [["url"], commands.OPTION_STRING, null, () => {
                        return [[buffer.URL, "target url"]];
                    }],
                    [["title"], commands.OPTION_STRING, null, () => {
                        return [[buffer.title, "target title"]];
                    }]
                ]
            }),

            new Command(["update"], "Update list", (args) => {
                let since = args["--force"] ? 0 : undefined;

                pktApi.update(since, {
                    success: (response) => {
                        echoMsg("Links successfully updated!");
                    }
                });
            }, {
                options: [
                    [["--force"], commands.OPTION_NOARG]
                ]
            }),

            new Command(["open"], "Open link", (args) => {
                openLink(args);
            }, {
                options: openOptions,
                completer: linkCompleter,
                literal: 0
            }),

            new Command(["tabnew"], "Open link in new tab", (args) => {
                openLink(args, liberator.NEW_TAB);
            }, {
                options: openOptions,
                completer: linkCompleter,
                literal: 0
            }),

            new Command(["rm"], "Remove link", (args) => {
                pktApi.removeLink(getLinkIdFromDescription(args[0]), {
                    success: () => {
                        echoMsg("Link removed!");
                    }
                });
            }, {
                completer: linkCompleter,
                literal: 0
            }),

            new Command(["clearcache"], "Clear cache", () => {
                pktApi.clearCache();
            }),

            new Command(["tag"], "Change tags on a link", () => {
                // TODO
            }, {
                subCommands: [
                    new Command(["add"], "Add tag", (args) => {
                        let linkId = getLinkIdFromDescription(args["link"]);
                        pktApi.addTag(linkId, args["tag"], {
                            success: () => {
                                echoMsg("Tag added!");
                            }
                        }).execute();
                    }, {
                        options: [
                            [["link"], commands.OPTION_STRING, null, getLinkCompletions],
                            [["tag"], commands.OPTION_STRING, null, getTagCompletions(true)]
                        ],
                        argsCount: "+",
                        literal: 0
                    }),

                    new Command(["rm"], "Remove tag", (args) => {
                        let linkId = getLinkIdFromDescription(args["link"]);
                        pktApi.removeTag(linkId, args["tag"], {
                            success: () => {
                                echoMsg("Tag removed!");
                            }
                        }).execute();
                    }, {
                        options: [
                            [["link"], commands.OPTION_STRING, null, getLinkCompletions],
                            [["tag"], commands.OPTION_STRING, null, getTagCompletions(false)]
                        ],
                        argsCount: "+",
                        literal: 0
                    }),

                    new Command(["clear"], "Clear all tags", (args) => {
                        let linkId = getLinkIdFromDescription(args[0]);
                        pktApi.clearTags(linkId, {
                            success: () => {
                                echoMsg("Tags cleared!");
                            }
                        })
                    }, {
                        literal: 0,
                        completer: linkCompleter
                    }),

                    new Command (["rename"], "Rename tag", (args) => {
                        let oldTag = args[0];
                        let newTag = args[1];

                        if(args["link"] !== undefined) {
                            let linkId = getLinkIdFromDescription(args["link"]);
                            pktApi.combineActions(
                                pktApi.removeTag(linkId, oldTag),
                                pktApi.addTag(linkId, newTag, {success: () => {echoMsg("Tag renamed!")}})
                            ).execute();
                        } else {
                            pktApi.renameTag(oldTag, newTag, {success: () => {echoMsg("Tag renamed!")}});
                        }
                    }, {
                        options: [
                            [["link"], commands.OPTION_STRING, null, getLinkCompletions]
                        ],
                        completer: tagCompleter
                    })
                ]
            })
    ]

    commands.addUserCommand(["pocket"], "Pocket plugin", (args) => {
        addLink(buffer.URL, buffer.title);
    }, {
        subCommands
    });

    pktApi.update();
})();
