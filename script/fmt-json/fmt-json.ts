import JSON5 from "json5";
import type { JsonValue } from "type-fest";

const sortKeys = (obj: JsonValue): JsonValue => {
  if (obj && typeof obj === "object" && !Array.isArray(obj)) {
    const entries = Object.entries(obj).toSorted(([a, _a], [b, _b]) => (
      a.localeCompare(b)
    ));
    return Object.fromEntries(entries);
  } else {
    return obj;
  }
};

const formatJson = async (jsonPath: string): Promise<void> => {
  const inputStr = await Deno.readTextFile(jsonPath);
  const inputData = JSON5.parse(inputStr);

  const outputData = sortKeys(inputData);
  const outputStr = JSON.stringify(outputData, null, 2);

  await Deno.writeTextFile(jsonPath, outputStr);
};

const main = (jsonPaths: ReadonlyArray<string>) =>
  Promise.all(jsonPaths.map(formatJson));

await main(Deno.args);
