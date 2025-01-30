const MarkdownIt = require("markdown-it");
const MarkdownItAnchor = require("markdown-it-anchor");
const syntaxHighlight = require("@11ty/eleventy-plugin-syntaxhighlight");
const pluginRss = require("@11ty/eleventy-plugin-rss");

module.exports = function(eleventyConfig) {
  eleventyConfig.setTemplateFormats(["md", "njk", "html", "css", "pdf", "liquid"]);

  eleventyConfig.addPassthroughCopy("CNAME");
  eleventyConfig.addPassthroughCopy({"assets/img": "img"});
  eleventyConfig.addPassthroughCopy({"assets/svg": "svg"});
eleventyConfig.addPassthroughCopy({"node_modules/reveal.js/dist/js": "reveal.js/dist/js"});
eleventyConfig.addPassthroughCopy({"node_modules/reveal.js/dist/css": "reveal.js/dist/css"});
eleventyConfig.addPassthroughCopy({"node_modules/reveal.js/plugin": "reveal.js/plugin"});
eleventyConfig.addPassthroughCopy({"assets/reveal.js-theme": "reveal.js/dist/theme"});
  eleventyConfig.addPassthroughCopy({"slides": "slides"});

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

  eleventyConfig.addPlugin(syntaxHighlight);
  eleventyConfig.addPlugin(pluginRss);

  eleventyConfig.addCollection("recentBlogPosts", (collectionApi) => {
    let i =0;
    return collectionApi.getFilteredByTag("blog").reverse().filter((item) => {
      return i++ < 10;
    });
  })
  eleventyConfig.addCollection("frontpageBlogPosts", (collectionApi) => {
    let i =0;
    return collectionApi.getFilteredByTag("blog").reverse().filter((item) => {
      return i++ < 4;
    });
  })
}
