# Analýza dostupnosti potravin a mezd v ČR

## 📌 Popis projektu
Tento projekt se zaměřuje na analýzu dostupnosti potravin v České republice v kontextu průměrných mezd a ekonomické situace. Využitím dostupných dat z otevřených zdrojů bylo vytvořeno robustní datové zázemí, které umožňuje odpovědět na klíčové výzkumné otázky týkající se růstu mezd, cen potravin a vlivu makroekonomických faktorů.

---

## 🎯 Cíl projektu
Projekt poskytuje analytický podklad pro porovnání růstu mezd a cen potravin v české společnosti, a zároveň analyzuje ekonomické ukazatele evropských zemí ve stejném období.

---

## 📊 Použité datové sady
Pro analýzu byla využita následující data:
- **czechia_payroll** – mzdy v různých odvětvích.
- **czechia_payroll_industry_branch** – názvy odvětví.
- **czechia_price** – historické ceny vybraných potravin.
- **czechia_price_category** – názvy potravin.
- **economies** – HDP, GINI koeficient, daňová zátěž atd.
- **countries** – informace o evropských zemích.

---

## 🏆 Hlavní výstupy
V rámci projektu byly vytvořeny dvě klíčové tabulky:

1. **t_krystof_karel_project_SQL_primary_final** – sjednocená data pro mzdy a ceny potravin v ČR.
2. **t_krystof_karel_project_SQL_secondary_final** – ekonomická data evropských zemí.

Dále jsou součástí projektu SQL dotazy, které odpovídají na následující otázky:
1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?

---

## 📂 Struktura repozitáře
- `sql/` – obsahuje SQL skripty pro vytvoření a analýzu tabulek.
- `docs/` – obsahuje popis dat, mezivýsledků a analýzu chybějících hodnot.
- `README.md` – tento soubor s přehledem projektu.

---

## 📌 Instalace a použití
Tento projekt nevyžaduje specifickou instalaci, pouze přístup k databázi a SQL klientovi. Stačí spustit přiložené SQL skripty v odpovídajícím prostředí.

---

## 🤝 Důležitost projektu
Projekt poskytuje klíčové informace pro odbornou i širší veřejnost, které mohou být využity při formulaci ekonomických politik a strategií v oblasti dostupnosti potravin. Zároveň slouží jako podklad pro prezentace na odborných konferencích a výzkumných diskuzích.

---

## ✉ Autor
- **Jméno**: Kryštof Karel
- **E-mail**: krystof.karel@gmail.com

---

## 📜 Licenční ujednání
Tento projekt je vytvořen pro analytické a vzdělávací účely. Data pochází z otevřených zdrojů a jsou využívána v souladu s jejich licenčními podmínkami.

