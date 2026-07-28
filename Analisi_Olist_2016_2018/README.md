# 📊 Dashboard BI — Analisi E-commerce Olist

## 📌 Descrizione del progetto

Report interattivo sviluppato in **Power BI** sul dataset pubblico **Olist**, piattaforma e-commerce brasiliana che connette venditori ai principali marketplace del Brasile.

Il dataset copre il periodo **2016-2018** e include ordini, prodotti, clienti e recensioni reali, resi anonimi per la pubblicazione.

---

## 🎯 Obiettivi di analisi

- 📦 **Andamento degli ordini nel tempo** — conteggio mensile con confronto anno precedente e variazione %
- 💰 **Andamento dei ricavi nel tempo** — ricavi mensili (prezzo + spedizione) con confronto anno precedente e variazione %
- ⭐ **Distribuzione del rating** — analisi della soddisfazione clienti per punteggio

---

## 🗂️ Struttura del modello dati

Il dataset è stato ristrutturato in uno **Star Schema** con:

- **Fact_Articoli** — tabella centrale con le metriche (price, freight_value, order_item_id)
- **Dim_Ordini** — status ordine, data acquisto
- **Dim_Clienti** — stato geografico, città
- **Dim_Prodotti** — categoria prodotto (tradotta dal portoghese)
- **Dim_Recensioni** — punteggio recensione
- **Dim_Calendario** — tabella calendario creata in DAX (2016-2018)

---

## 📐 Misure DAX

| Misura | Descrizione |
|--------|-------------|
| `Ordini Totali` | DISTINCTCOUNT degli ordini unici |
| `Ricavi Totali` | SUMX di price + freight_value |
| `Ordini Anno Precedente` | CALCULATE + SAMEPERIODLASTYEAR |
| `Ricavi Anno Precedente` | CALCULATE + SAMEPERIODLASTYEAR |
| `Var. % Ordini` | Variazione percentuale ordini YoY |
| `Var. % Ricavi` | Variazione percentuale ricavi YoY |
| `Insoddisfatti` | Recensioni con punteggio 1-2 |
| `Neutrali` | Recensioni con punteggio 3 |
| `Soddisfatti` | Recensioni con punteggio 4-5 |

---

## 📄 Pagine del report

1. **Introduzione** — Descrizione del progetto e indice delle analisi
2. **Processo Tecnico** — Metodologia e scelte tecniche adottate
3. **Performance Ordini nel Tempo** — Grafico combinato, KPI cards, Top Categorie con drill-through
4. **Performance Ricavi nel Tempo** — Analisi ricavi mensili in R$
5. **Analisi Recensioni** — Distribuzione voti, grafico a torta, cards colorate
6. **Ordini e Ricavi in Brasile** — Mappa interattiva con bolle e tooltip
7. **Dettaglio Prodotti** — Pagina nascosta accessibile tramite drill-through

---

## 🛠️ Tecnologie e strumenti

- **Power BI Desktop**
- **Power Query** — pulizia e trasformazione dati
- **DAX** — misure e colonne calcolate
- **JSON** — tema personalizzato con palette colori Olist

---

## 📁 File nel repository

| File | Descrizione |
|------|-------------|
| `Analisi_Olist.pbix` | File Power BI completo |
| `Analisi_Olist.pdf` | Export PDF del report |

---

## 🎨 Tema

Report sviluppato con tema personalizzato ispirato ai colori ufficiali **Olist**:
- Blu primario: `#1A56FF`
- Arancione accento: `#F5A623`
