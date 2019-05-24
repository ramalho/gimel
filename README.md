# Gimel

Utility to search Unicode characters by words in their names.

## Using

Run `gimel` to get a prompt for searching:

```
$ ./gimel
Enter /q to quit.
Search: cat
U+A2B6	ꊶ	YI SYLLABLE CAT
U+101EC	𐇬	PHAISTOS DISC SIGN CAT
U+1F408	🐈	CAT
U+1F431	🐱	CAT FACE
U+1F638	😸	GRINNING CAT FACE WITH SMILING EYES
U+1F639	😹	CAT FACE WITH TEARS OF JOY
U+1F63A	😺	SMILING CAT FACE WITH OPEN MOUTH
U+1F63B	😻	SMILING CAT FACE WITH HEART-SHAPED EYES
U+1F63C	😼	CAT FACE WITH WRY SMILE
U+1F63D	😽	KISSING CAT FACE WITH CLOSED EYES
U+1F63E	😾	POUTING CAT FACE
U+1F63F	😿	CRYING CAT FACE
U+1F640	🙀	WEARY CAT FACE
(13 found)
Search: cat eyes
U+1F638	😸	GRINNING CAT FACE WITH SMILING EYES
U+1F63B	😻	SMILING CAT FACE WITH HEART-SHAPED EYES
U+1F63D	😽	KISSING CAT FACE WITH CLOSED EYES
(3 found)
Search: /q
$
```

The search returns characters that have all the words in the query, as whole words.

You can also provide search words in the command line:

```
$ ./gimel fire
U+2632	☲	TRIGRAM FOR FIRE
U+2EA3	⺣	CJK RADICAL FIRE
U+2F55	⽕	KANGXI RADICAL FIRE
U+322B	㈫	PARENTHESIZED IDEOGRAPH FIRE
U+328B	㊋	CIRCLED IDEOGRAPH FIRE
U+4DDD	䷝	HEXAGRAM FOR THE CLINGING FIRE
U+1F525	🔥	FIRE
U+1F692	🚒	FIRE ENGINE
U+1F6F1	🛱	ONCOMING FIRE ENGINE
U+1F702	🜂	ALCHEMICAL SYMBOL FOR FIRE
U+1F9EF	🧯	FIRE EXTINGUISHER
(11 found)
Search: 
```

## Testing

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


## Building

Build standalone CLI script:

```
$ mix escript.build
```

Building `gimel` requires the `priv/UnicodeData.txt` file.

Every year or so the **Unicode Consortium** publishes a new database, adding new characters. Before building a new release of `gimel`, please update the local copy of `UnicodeData.txt` inside `priv/`. The current database can be downloaded from:

[`http://www.unicode.org/Public/UNIDATA/UnicodeData.txt`](http://www.unicode.org/Public/UNIDATA/UnicodeData.txt)
