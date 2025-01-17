# Regiojet Checker

Jednoducha terminalova aplikacia umoznujuca odchyt [Regiojet.cz](https://regiojet.cz/) listkov v pripade, ze uz su vypredane. Vyuziva sluzbu [notify.run](https://notify.run/), vdaka ktorej je mozne dostavat upozornenia z aplikacie na niekolkych zariadeniach zaroven - staci, ze podporuju PUSH notifikacie (tj. mobily, tablety, pocitace).

## Konfiguracia

Aplikacia vyhladava listky podla konfiguracie vo forme YAML manifestu (standardny nazov `config.yaml`), ktora obsahuje vsetky potrebne informacie o vlaku a pozadovanom listku.

| Kluc              | Popis                | Mozne hodnoty                                      |
| ----------------- | -------------------- | -------------------------------------------------- |
| `date`            | Datum odchodu vlaku  | Datum vo formate "YYYY-MM-DD"                      |
| `time`            | Cas odchodu vlaku    | Cas vo formate "HH:MM"                             |
| `from`            | Vychodzia stanica    | ID lokality, viz. [locations.md](locations.md)     |
| `to`              | Destinacia           | ID lokality, viz. [locations.md](locations.md)     |
| `preffered_class` | Chcena trieda        | Kluc triedy, viz. [classes.md](classes.md)         |
| `tariff`          | Tarif listku/listkov | Kluc tarifu/tarifov, viz. [tariffs.md](tariffs.md) |
| `notify_code`     | notify.run kanal     | Kod notify.run kanala, viz. [nizsie](#notifyrun)   |

### Viacero listkov

V ramci konfiguracneho suboru je mozne definovat viacero listkov - staci pre kluc `tariff` definovat take tarify listkov, ake su pozadovane. Pre jeden listok `tariff` moze vyzerat napriklad takto:

```
tariff: REGULAR
```

V pripade viacerych listkov (napriklad 2x Dospely, 1x Senior) vyzera nasledovne:

```
tariff:
  - REGULAR
  - REGULAR
  - ISIC
```

Pre ukazku konfiguracneho suboru viz. [config.yaml](config.yaml).

### [notify.run](https://notify.run/)

Pre vyuzitie sluzby notify.run staci vytvorit na stranke sluzby kanal (modre tlacidlo "Create channel"). Na stranke kanala mozno prihlasit zariadenia k odberu PUSH notifikacii (modre tlacidlo "Subscribe" na konci). Do konfiguracie je nutne zadat kod kanala, ktory sa nachadza na konci odkazu a zaroven je aj jeho nazvom.

## Spustenie aplikacie

Pre spustenie aplikacie je mozne vyuzit predpripraveny script `rjchecker.py`. Script je prednastaveny tak, ze vyhladava konfiguracny subor `config.yaml`, avsak ponuka moznost nacitat aj iny konfiguracny subor pomocou prepinaca `-c <config_file>`.

```
$ python3 rjchecker.py
$ python3 rjchecker.py -c another_config.yaml
```

Po spusteni aplikacia kazdych 20 sekund vyhladava pozadovanu konfiguraciu. V pripade volnych listkov odosle notifikaciu na zadany notify.run kanal a uspi sa na 5 minut. Po kliknuti na notifikaciu sa otvori prehliadac na vyhladavani Regiojet.cz so zadanou konfiguraciou.
