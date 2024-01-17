# jekyll-fetch-notion

The Jekyll plugin introduces the `fetch_notion` command. This command fetches all Notion
content as specified by the `_config.yml` file and places it directly into your git
repository, respecting the corresponding directory structure. This project is a fork of
[jekyll-notion][1], created due to incompatible synchronization methods. You can find more
details in [this pull request][10].

*Note: Data and page fetching are planned for future releases but are not yet available.*

The original project was designed with the idea that Notion content should be fetched
during site building and not tracked by git. This project, however, takes a different
approach. It arranges your workflow so that your Notion content is git-tracked and
fetched before site building.

I believe this method aligns better with Jekyll's "ideology" and also offers several
advantages:

- Your Notion content is git-tracked and preserved. This ensures a smooth transition from
  Notion back to plain `.md` editing or to another synchronization tool. As Jekyll is a
  static site generator, everything remains static.
- Separating Notion synchronization from site building simplifies the process and
  provides you more precise control. For example, you again can git-clone and build a
  site as-is without Notion token.

However, every implementation has its own pros and cons. Choose the one that best suits
your needs.

For more insights into my experience with `jekyll-fetch-notion`, check out these posts:

- [Yet another way to establish Notion + Jekyll synchronization][12]
- [Notion + Jekyll images synchronization][11]

## Installation

Use `gem` to install:

```bash
gem install 'jekyll-fetch-notion'
```

Or add it to the `Gemfile`:

```ruby
gem 'jekyll-fetch-notion'
```

And then update your jekyll plugins property in `_config.yml`:

```yml
plugins:
  - jekyll-fetch-notion
```

## Usage

Before using the gem, create an integration and generate a secret token. For more in-depth
instructions refer to the Notion "Getting Started" [guide][2].

Once you have your secret token, make sure to export it into an environment variable named
`NOTION_TOKEN`:

```bash
export NOTION_TOKEN=<secret_...>
```

Then you can run command to fetch all the Notion content and place it inside your's site
repository:

```bash
jekyll fetch_notion
```

Then you probably need to stage, commit and push all the fetched files to trigger your
default CI build flow and make your updated site deployed.

### Databases

Once the [notion database][3] has been shared, specify the database `id` in the
`_config.yml` file as follows:

```yml
notion:
  databases:
    - id: 5cfed4de3bdc4f43ae8ba653a7a2219b
```

By default, the notion pages in the database will be loaded into the `posts` collection.

We can also define multiple databases as follows:

```yml
collections:
  - recipes
  - films

notion:
  databases:
    - id: b0e688e199af4295ae80b67eb52f2e2f
    - id: 2190450d4cb34739a5c8340c4110fe21
      collection: recipes
    - id: e42383cd49754897b967ce453760499f
      collection: films
```

After running `jekyll fetch_notion` command, the `posts`, `recipes` and `films`
collections will be fetched with pages from the notion databases.

#### Database options

Each dabatase support the following options.

- `id`: the notion database unique identifier
- `collection`: the collection each page belongs to (posts by default)
- `filter`: the database [filter property][4]
- `sorts`: the database [sorts criteria][5]

```yml
notion:
  databases:
    - id: e42383cd49754897b967ce453760499f
      collection: posts
      filter: { "property": "Published", "checkbox": { "equals": true } }
      sorts: [{ "timestamp": "created_time", "direction": "ascending" }]
```

#### Posts date

The `created_time` property of a notion page is used to set the date in the post filename.
This is the date used for the `date` variable of the [predefined variables for posts][6].

It's important to note that the `created_time` cannot be modifed. However, if you wish to
change the date of a post, you can create a new page property named "date" (or "Date").
This way, the posts collection will use the `date` property for the post date variable
instead of the `created_time`.

### Notion properties

Notion page properties are set for each document in the front matter.

Please, refer to the [notion_to_md][8] gem to learn more.

### Page filename

There are two kinds of documents in Jekyll: posts and others.

When the document is a post, the filename format contains the `created_time` property
plus the page title as specified in [jekyll docs][9].

```
YEAR-MONTH-DAY-title.MARKUP
```

The filename for any other document is the page title.

## Alternatives

Actually, there are a lot of alternatives available, but, however, mostly all of them are
not so mature and hard to extend. This one (like `jekyll-notion`) is tested by time and
easy to extend because of `notion_to_md` usage.

[1]: https://github.com/emoriarty/jekyll-notion
[2]: https://developers.notion.com/docs/getting-started
[3]: https://developers.notion.com/docs/working-with-databases
[4]: https://developers.notion.com/reference/post-database-query-filter
[5]: https://developers.notion.com/reference/post-database-query-sort
[6]: https://jekyllrb.com/docs/front-matter/#predefined-variables-for-posts
[7]: https://jekyllrb.com/docs/permalinks/#front-matter
[8]: https://github.com/emoriarty/notion_to_md/
[9]: https://jekyllrb.com/docs/posts/#creating-posts
[10]: https://github.com/emoriarty/jekyll-notion/pull/68
[11]: https://seroperson.me/2023/11/16/notion-jekyll-images-synchronization/
[12]: https://seroperson.me/2023/08/26/yet-another-way-to-establish-notion-jekyll-synchronization/
