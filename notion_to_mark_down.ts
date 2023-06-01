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

const pages = [
  { name: "Readme", token: "6df40dd4e66744bea38fcbe4dc97af9c", filePath: "README.md" },
  { name: "Scheduling", token: "8819161ad7a840188d2c8266e1db324a", filePath: "scheduling/scheduling.md" },
  {name: "Distributed Systems", token: "aec802de8876479983053855e304f549", filePath: "distributed_systems.md"}
];

// NotionToMarkdown instance
const n2m = new NotionToMarkdown({ notionClient: notion });

(async () => {
  for (const page of pages) {
    const mdblocks = await n2m.pageToMarkdown(page.token);
    const mdString = n2m.toMarkdownString(mdblocks);
    fs.writeFileSync(page.filePath, mdString.parent, "utf8");
  }
})();