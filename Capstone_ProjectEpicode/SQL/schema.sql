-- ============================================
-- SCHEMA DATABASE - Roma o Sabina?
-- Capstone Project - Matteo Marchesani
-- EPICODE School 2026
-- ============================================

CREATE DATABASE IF NOT EXISTS Roma_o_sabina;
USE Roma_o_sabina;

-- ============================================
-- TABELLA ANNUNCI
-- Dati raccolti tramite scraping da Immobiliare.it
-- Fonte: Immobiliare.it - Giugno 2026
-- ============================================

CREATE TABLE annunci (
    id                  INT AUTO_INCREMENT PRIMARY KEY,
    comune              VARCHAR(100),
    tipo_contratto      VARCHAR(20),        -- 'vendita' o 'affitto'
    prezzo              VARCHAR(50),        -- valore originale testuale
    locali              VARCHAR(20),        -- valore originale testuale
    superficie          VARCHAR(20),        -- valore originale testuale
    url_annuncio        VARCHAR(255),
    data_scraping       DATE,
    zona                VARCHAR(100),       -- solo per Roma (es. 'centro-storico')
    macroarea           VARCHAR(50),        -- 'Roma Centro', 'Roma Semicentro', 'Roma Periferia', 'Sabina Romana', 'Bassa Sabina'
    prezzo_num          FLOAT,              -- prezzo convertito in numero
    superficie_num      FLOAT,              -- superficie in mq convertita in numero
    locali_num          FLOAT,              -- numero locali convertito in numero
    prezzo_mq           FLOAT,              -- prezzo al metro quadro (solo vendita)
    valido              INT DEFAULT 1,      -- 1 = annuncio valido, 0 = asta/outlier
    Fascia_Prezzo       VARCHAR(50)         -- fascia di prezzo per il simulatore
);

-- ============================================
-- TABELLA COSTO_VITA
-- Dati ISTAT 2023 aggiornati con inflazione +4.2% al 2026
-- Fonte: ISTAT - Indagine Spese per Consumi delle Famiglie 2023
-- ============================================

CREATE TABLE costo_vita (
    id                  INT AUTO_INCREMENT PRIMARY KEY,
    comune              VARCHAR(100),
    macroarea           VARCHAR(50),
    spesa_mensile       INT,                -- spesa mensile familiare media (ISTAT, aggiornata 2026)
    costo_trasporti     INT,                -- costo mensile stimato trasporti verso Roma
    km_da_roma          INT,                -- distanza in km da Roma centro
    collegamento_treno  BOOLEAN,            -- accesso alla linea FL1
    fonte               VARCHAR(200),       -- fonte del dato
    anno                INT                 -- anno di riferimento
);

-- ============================================
-- NOTE METODOLOGICHE
-- 
-- Flag 'valido':
--   valido = 1: annunci con prezzo_mq tra 500 e 15.000 €/mq
--   valido = 0: immobili all'asta (prezzo "da €..."), outlier estremi
--
-- Costo trasporti:
--   Con treno FL1: costo abbonamento mensile Metrebus (39-56€) + 
--                  eventuale costo auto per raggiungere la stazione
--   Senza treno:   km_da_roma × 2 × 22 giorni × 0.18 €/km (ACI 2023)
--
-- Spesa mensile ISTAT:
--   Roma città: 2.976€/mese (nucleo familiare medio 2,2 persone)
--   Provincia Roma: 2.800€/mese
--   Provincia Rieti: 2.626€/mese
--   Tutti i valori aggiornati con inflazione cumulativa +4.2% al 2026
-- ============================================
