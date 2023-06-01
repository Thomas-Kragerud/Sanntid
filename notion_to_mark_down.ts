const { Client } = require("@notionhq/client");
const { NotionToMarkdown } = require("notion-to-md");
const fs = require('fs');
// or
// import {NotionToMarkdown} from "notion-to-md";

const notion = new Client({
  auth: "secret_If3nUOfAsOruBJoPziCaEzaKrjh6DkqAciB7m91bRIQ",
  config:{
     separateChildPage:true, // default: false
  }
});

// passing notion client to the option
const n2m = new NotionToMarkdown({ notionClient: notion });

(async () => {
  const mdblocks = await n2m.pageToMarkdown("675352bdd02b40278698c99e4d0a38a7");
  const mdString = n2m.toMarkdownString(mdblocks);
  //const mdString = JSON.stringify(n2m.toMarkdownString(mdblocks));

  console.log(mdString.parent);
  //fs.writeFileSync('./foo.md', mdString, 'utf8');

})();