# Gimel

Run automated tests (excluding tests tagged `:slow`):

```
$ mix test
```


Run all automated tests:

```
$ mix test --include slow
```


Manual testing of CLI:

```
$ mix run -e "Gimel.CLI.main()"
```


Build CLI script:

```
$ mix escript.build
```