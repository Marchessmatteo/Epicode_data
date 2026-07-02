# 🏡 Roma o Sabina?
### Un'analisi data-driven del mercato immobiliare per chi vuole lasciare la capitale

> **Capstone Project — EPICODE School Data Analytics 2026**  
> **Autore:** Matteo Marchesani

---

## 📌 Il Progetto

Vivo in Sabina, a pochi chilometri da Roma. La domanda *"conviene davvero lasciare la capitale?"* è una scelta reale che tante famiglie affrontano ogni giorno — e io stesso me la sono posta.

Cercando online, ho notato che non esiste nessun strumento che vada oltre il semplice annuncio: nessuna app, nessun sito che raggruppi i dati per macroarea, confronti i costi di vita reali, e risponda concretamente a *"dove conviene vivere?"*

**Ho deciso di costruirlo io, con i dati.**

---

## 🎯 Obiettivo

Confrontare prezzi immobiliari, affitti e costo della vita reale tra **Roma** e i comuni della **Sabina** per rispondere alla domanda:

> *Conviene comprare o affittare in Sabina nel 2026?*

---

## 🗺️ Aree di Analisi

| Macroarea | Province | Comuni |
|---|---|---|
| Roma Centro | Roma | Centro storico, Prati, Trastevere, Flaminio |
| Roma Semicentro | Roma | Pigneto, Ostiense, Centocelle, Casal Bertone |
| Roma Periferia | Roma | Ponte di Nona, Bufalotta, Spinaceto |
| Sabina Romana | Roma | Mentana, Monterotondo, Palombara Sabina, Nerola + altri |
| Bassa Sabina | Rieti | Fara in Sabina, Poggio Mirteto, Magliano Sabina + altri |

---

## 📊 Risultati Principali

| KPI | Valore |
|---|---|
| Annunci analizzati | 4.841 |
| Prezzo trilocale Bassa Sabina | ~96.655€ |
| Prezzo trilocale Roma Centro | ~737.242€ |
| Risparmio affitto mensile (Bassa Sabina vs Roma Periferia) | ~732€/mese |
| Risparmio totale annuo (affitto + vita + trasporti) | ~9.500€/anno |
| Break-even acquisto Roma Periferia | ~14 anni |
| Break-even acquisto Sabina Romana | ~19 anni |

---

## 🛠️ Stack Tecnologico

```
Python 3.x          → Scraping e pulizia dati
├── requests        → Richieste HTTP
├── BeautifulSoup   → Parsing HTML
├── pandas          → Manipolazione dati
├── mysql-connector → Connessione MySQL
└── python-dotenv   → Gestione credenziali

MySQL               → Database locale
└── 2 tabelle: annunci (4.841 righe) + costo_vita (28 righe)

Power BI Desktop    → Dashboard interattiva
└── 8 pagine con drill-down, drill-through e simulatore
```

---

## 📁 Struttura del Repository

```
roma-o-sabina/
├── Scraper.ipynb          # Notebook scraping + pulizia dati
├── data/
│   └── clean/
│       └── annunci_clean.csv    # Dataset pulito (4.841 righe)
├── SQL/
│   ├── schema.sql         # Schema database
│   └── queries.sql        # Query analitiche
├── PowerBI/
│   └── Roma_o_Sabina_Dashboard.pbix   # Dashboard Power BI
├── Relazioni/             # Presentazione del progetto
└── README.md
```

---

## 🔄 Pipeline del Progetto

```
Immobiliare.it
      ↓
Python (requests + BeautifulSoup)
      ↓ scraping
data/raw/*.csv (50+ file CSV per comune)
      ↓
Python (pandas)
      ↓ pulizia + flag valido
data/clean/annunci_clean.csv
      ↓
MySQL (mysql-connector + pandas.to_sql)
      ↓ caricamento
Database Roma_o_sabina
      ↓
Power BI Desktop
      ↓ visualizzazione
Dashboard interattiva (8 pagine)
```

---

## 📋 Metodologia

### Scraping
- Fonte: [Immobiliare.it](https://www.immobiliare.it)
- Periodo: Giugno 2026
- Dati raccolti: comune, macroarea, tipo contratto, prezzo, superficie, locali, url annuncio
- Paginazione automatica con gestione anti-bot (headers personalizzati)

### Pulizia Dati
- Conversione prezzi da testo a numero (regex)
- Flag `valido`: esclude aste (`prezzo_mq < 500€`) e outlier (`prezzo_mq > 15.000€`)
- I dati esclusi sono preservati e visibili nella pagina "Opportunità"

### Costo Vita
- Fonte: ISTAT 2023 — Indagine Spese per Consumi delle Famiglie
- Aggiornati con inflazione cumulativa +4,2% al 2026
- Costi trasporti stimati: abbonamento FL1 o formula ACI (km × 2 × 22 × 0,18€/km)

---

## 📊 Dashboard Power BI — 8 Pagine

| Pagina | Contenuto |
|---|---|
| Cover | Presentazione e storia del progetto |
| Overview | Mappa interattiva con drill-through |
| Prezzi | €/mq e affitti per macroarea |
| Costo Totale | Affitto + vita ISTAT + trasporti |
| Conclusioni | Break-even e raccomandazione finale |
| Simulatore | Ricerca per fascia di prezzo (vendita/affitto) |
| Opportunità | Aste e annunci con prezzo anomalo |
| Dettaglio Comune | Tutti gli annunci per comune (drill-through) |

---

## ⚠️ Limiti del Progetto

- Dati limitati a Giugno 2026 (snapshot statico)
- Spesa ISTAT disponibile a livello provinciale, non comunale
- Blocco Cloudflare ha impedito l'ampliamento a nuovi comuni durante lo sviluppo
- Costi trasporti stimati (non dati reali di spesa)

---

## 🔮 Sviluppi Futuri

- Aggiornamento periodico dati tramite scraping schedulato
- Ampliamento a nuovi comuni (Sabina Valle del Tevere, Alta Sabina)
- Scenario Single vs Famiglia nel simulatore
- Integrazione con dati catastali per analisi rendimento immobiliare

---

## 👤 Autore

**Matteo Marchesani**  
Data Analytics Student — EPICODE School  
📎 [Portfolio](https://sites.google.com/view/matteomarchesani-dataanalyst)

---

*Progetto realizzato come Capstone Project del corso Data Analytics di EPICODE School — 2026*
