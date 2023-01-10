const MarkdownIt = require("markdown-it");
const MarkdownItAnchor = require("markdown-it-anchor");

module.exports = function(eleventyConfig) {
  eleventyConfig.addPassthroughCopy({"assets/img": "img"});
  eleventyConfig.addPassthroughCopy({"assets/svg": "svg"});

  eleventyConfig.addShortcode("currentYear", () => `${new Date().getFullYear()}`);

  eleventyConfig.setLibrary("md", MarkdownIt({
    html: true,
    typographer: true,
    linkify: true
  }).use(MarkdownItAnchor, {
    permalink: MarkdownItAnchor.permalink.linkInsideHeader({
      symbol: `
        <span class="icon hashlink"><i class="fas fa-link"></i></span>
      `,
    })
  }));
}
