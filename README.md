# Shopnomix

This is a project that receive words and perform operations in them, there are four operations available and you can perform this operations through a HTTP request, all calls are POST.

The four operations available are:

### Insertion
POST /api/insert
```json
{
   "text":"word challenge",
   "text_to_insert":"processor ",
   "position":5
}
```
Result:
```json
{"word": "word processor challenge"}
```

### Deletion 
POST /api/delete
```json
{
   "text":"Lionel texttoberemoved Messi",
   "start_position":8,
   "end_position":23
}
```
Result:
```json
{"word": "Lionel Messi"}
```


### Replace:
POST /api/replace
```json
{
   "text":"drink juice",
   "substring":"juice",
   "text_to_replace":"soda"
}
```
Result:
```json
{"word": "drink soda"}
```


###  
POST /api/search
```json
{
   "text":"occurence first second first",
   "substring":"first"
}
```
Result:
```json
{"index": 10}
```


```json
{
   "text":"not",
   "substring":"found pattern"
}
```
Result:
```json
{"index": -1}
```

## Install
To start the project:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can make requests to [`localhost:4000`](http://localhost:4000) and start using the project.
