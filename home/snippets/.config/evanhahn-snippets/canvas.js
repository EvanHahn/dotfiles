// @ts-check

const canvas = document.createElement("canvas");
const context = canvas.getContext("2d");

/**
 * @param {HTMLCanvasElement} canvas
 * @returns {void}
 */
function makeCanvasFillScreen(canvas) {
  canvas.width = Math.ceil(innerWidth * devicePixelRatio);
  canvas.height = Math.ceil(innerHeight * devicePixelRatio);
  canvas.style.width = "100vw";
  canvas.style.height = "100vh";
}

makeCanvasFillScreen();
addEventListener("resize", () => {
  makeCanvasFillScreen(canvas);
});

document.body.append(canvas);
