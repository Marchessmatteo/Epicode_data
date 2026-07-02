-- ============================================
-- QUERY ANALITICHE - Roma o Sabina?
-- ============================================

-- 1. Prezzo medio al mq per macroarea (vendita)
SELECT 
    macroarea,
    ROUND(AVG(prezzo_mq), 2) AS prezzo_mq_medio,
    COUNT(*) AS numero_annunci
FROM annunci
WHERE valido = 1 
    AND tipo_contratto = 'vendita'
    AND prezzo_mq IS NOT NULL
GROUP BY macroarea
ORDER BY prezzo_mq_medio DESC;

-- 2. Affitto medio mensile per macroarea
SELECT 
    macroarea,
    ROUND(AVG(prezzo_num), 2) AS affitto_medio_mensile,
    COUNT(*) AS numero_annunci
FROM annunci
WHERE valido = 1 
    AND tipo_contratto = 'affitto'
    AND prezzo_num IS NOT NULL
GROUP BY macroarea
ORDER BY affitto_medio_mensile DESC;

-- 3. Prezzo medio trilocale per macroarea (vendita)
SELECT 
    macroarea,
    ROUND(AVG(prezzo_num), 2) AS prezzo_medio_trilocale,
    COUNT(*) AS numero_annunci
FROM annunci
WHERE valido = 1 
    AND tipo_contratto = 'vendita'
    AND locali_num = 3
    AND prezzo_num IS NOT NULL
GROUP BY macroarea
ORDER BY prezzo_medio_trilocale DESC;

-- 4. Break-even affitto vs acquisto (anni)
-- Quanti anni ci vogliono per ammortizzare l'acquisto vs affitto
SELECT 
    macroarea,
    ROUND(AVG(prezzo_mq), 2) AS prezzo_mq_medio,
    ROUND(AVG(prezzo_num), 2) AS affitto_medio_mensile,
    ROUND(
        (SELECT AVG(a2.prezzo_num) 
         FROM annunci a2 
         WHERE a2.macroarea = annunci.macroarea 
         AND a2.tipo_contratto = 'vendita' 
         AND a2.valido = 1) 
        / (AVG(prezzo_num) * 12), 2
    ) AS anni_break_even
FROM annunci
WHERE valido = 1 
    AND tipo_contratto = 'affitto'
    AND prezzo_num IS NOT NULL
GROUP BY macroarea
ORDER BY anni_break_even ASC;

-- 5. Risparmio mensile affitto vs Roma Periferia
SELECT 
    macroarea,
    ROUND(AVG(prezzo_num), 2) AS affitto_medio,
    ROUND(
        (SELECT AVG(a2.prezzo_num) 
         FROM annunci a2 
         WHERE a2.macroarea = 'Roma Periferia' 
         AND a2.tipo_contratto = 'affitto' 
         AND a2.valido = 1)
        - AVG(prezzo_num), 2
    ) AS risparmio_vs_periferia
FROM annunci
WHERE valido = 1 
    AND tipo_contratto = 'affitto'
    AND prezzo_num IS NOT NULL
GROUP BY macroarea
ORDER BY risparmio_vs_periferia DESC;