-- =====================================================================
-- SQL Faker :: locale de_DE (German / Germany)
-- =====================================================================
INSERT INTO locales (code, name, units) VALUES ('de_DE', 'Deutsch (Deutschland)', 'metric')
ON CONFLICT (code) DO NOTHING;

-- ---------------------------------------------------------------- names
CALL fk_add_words('de_DE', 'first_name_M', $$
Alexander|Andreas|Anton|Armin|Arne|Axel|Benedikt|Benjamin|Bernd|Björn|Christian|Christoph|Claus|Daniel|David|Dennis|Dieter|Dirk|Dominik|Elias|
Emil|Erik|Ernst|Fabian|Felix|Finn|Florian|Frank|Franz|Friedrich|Georg|Gerhard|Günter|Hans|Harald|Heinrich|Heinz|Helmut|Henrik|Herbert|
Holger|Horst|Hubert|Jan|Jannik|Jens|Joachim|Johannes|Jonas|Jonathan|Jörg|Josef|Julian|Jürgen|Kai|Karl|Karsten|Klaus|Konrad|Kurt|
Lars|Leon|Leonard|Lorenz|Louis|Luca|Lukas|Manfred|Marcel|Marco|Mario|Markus|Martin|Mathias|Matthias|Max|Maximilian|Michael|Moritz|Niklas|
Nico|Norbert|Oliver|Oskar|Otto|Pascal|Patrick|Paul|Peter|Philipp|Rainer|Ralf|Reinhard|Robert|Robin|Roland|Rolf|Rudolf|Sascha|Sebastian|
Simon|Stefan|Steffen|Sven|Thomas|Thorsten|Tim|Timo|Tobias|Torsten|Udo|Ulrich|Uwe|Valentin|Volker|Walter|Werner|Wilhelm|Wolfgang|Yannick|
Ben|Noah|Henry|Theo|Mats|Luis|Jakob|Liam|Milan|Matteo|Hannes|Ole|Malte|Bastian|Carsten|Detlef|Eberhard|Egon|Erwin|Fritz|
Gerd|Gustav|Hartmut|Hermann|Ingo|Kevin|Konstantin|Leopold|Linus|Lothar|Ludwig|Manuel|Marius|Mirko|Nils|Olaf|Raphael|René|Richard|Rüdiger|
Sandro|Siegfried|Silas|Sönke|Thilo|Till|Vincent|Winfried|Benno|Bruno|Carl|Clemens|Cornelius|Damian|Erich|Ferdinand|Gregor|Gunnar|Hagen|Ivo|
Jasper|Joscha|Justus|Kilian|Knut|Lennart|Levin|Magnus|Mattis|Merlin|Severin|Torben|Ulf|Viktor|Adrian|Aaron|Emilian|Friedhelm|Gottfried|Wendelin$$);

CALL fk_add_words('de_DE', 'first_name_F', $$
Anna|Andrea|Angelika|Anja|Anke|Annette|Antje|Barbara|Bärbel|Beate|Bettina|Birgit|Brigitte|Carina|Carmen|Charlotte|Christa|Christiane|Christina|Claudia|
Cornelia|Dagmar|Daniela|Doris|Elena|Elisabeth|Ella|Emilia|Emma|Erika|Eva|Franziska|Frieda|Gabriele|Gerda|Gisela|Greta|Gudrun|Hanna|Hannah|
Heike|Helga|Helene|Hildegard|Ida|Ilse|Ines|Ingrid|Irene|Iris|Jana|Janina|Jennifer|Johanna|Julia|Jutta|Karin|Katharina|Kathrin|Katja|
Kerstin|Klara|Lara|Laura|Lea|Lena|Leonie|Lina|Lisa|Luisa|Magdalena|Maja|Manuela|Mareike|Maria|Marie|Marion|Marlene|Martina|Melanie|
Mia|Michaela|Mila|Monika|Nadine|Natalie|Nicole|Nina|Paula|Petra|Renate|Ricarda|Ruth|Sabine|Sabrina|Sandra|Sara|Silke|Simone|Sofia|
Sophie|Stefanie|Susanne|Svenja|Tanja|Theresa|Ulrike|Ursula|Ute|Vanessa|Verena|Waltraud|Yvonne|Anneliese|Annika|Astrid|Bianca|Carla|Clara|Constanze|
Diana|Dorothea|Edith|Elke|Elfriede|Emily|Fenja|Frauke|Friederike|Gertrud|Gesine|Hedwig|Heidi|Henriette|Ingeborg|Isabel|Jasmin|Josephine|Jule|Karla|
Karoline|Lilli|Lotte|Luise|Margarete|Marta|Mathilda|Merle|Miriam|Nele|Paulina|Pia|Regina|Rosemarie|Sigrid|Sonja|Stella|Tina|Viktoria|Wiebke|
Zoe|Alina|Amelie|Antonia|Finja|Jette|Leni|Liv|Romy|Selina|Thea|Valentina|Vivien|Annegret|Brunhilde|Elsa|Gretchen|Hilde|Irmgard|Lieselotte$$);

CALL fk_add_words('de_DE', 'last_name', $$
Müller|Schmidt|Schneider|Fischer|Weber|Meyer|Wagner|Becker|Schulz|Hoffmann|Schäfer|Koch|Bauer|Richter|Klein|Wolf|Schröder|Neumann|Schwarz|Zimmermann|
Braun|Krüger|Hofmann|Hartmann|Lange|Schmitt|Werner|Schmitz|Krause|Meier|Lehmann|Schmid|Schulze|Maier|Köhler|Herrmann|König|Walter|Mayer|Huber|
Kaiser|Fuchs|Peters|Lang|Scholz|Möller|Weiß|Jung|Hahn|Schubert|Vogel|Friedrich|Keller|Günther|Frank|Berger|Winkler|Roth|Beck|Lorenz|
Baumann|Franke|Albrecht|Schuster|Simon|Ludwig|Böhm|Winter|Kraus|Martin|Schumacher|Krämer|Vogt|Stein|Jäger|Otto|Sommer|Groß|Seidel|Heinrich|
Brandt|Haas|Schreiber|Graf|Schulte|Dietrich|Ziegler|Kuhn|Kühn|Pohl|Engel|Horn|Busch|Bergmann|Thomas|Voigt|Sauer|Arnold|Wolff|Pfeiffer|
Ernst|Lindner|Hübner|Kramer|Franz|Jansen|Hansen|Paul|Thiel|Hein|Herzog|Brinkmann|Wendt|Kroll|Ritter|Schütz|Hesse|Schilling|Böttcher|Kraft|
Vetter|Dittrich|Gerlach|Schwab|Marx|Kolb|Kuhlmann|Kurz|Reuter|Ebert|Brenner|Nowak|Ahrens|Bach|Bischoff|Buchholz|Busse|Dörr|Ebner|Eckert|
Eggert|Esser|Fiedler|Fink|Frey|Fritz|Geiger|Gebhardt|Göbel|Götz|Hagen|Hammer|Hartung|Heinemann|Hermann|Hess|Hirsch|Hoppe|Jacob|Jakob|
Janssen|Kaufmann|Kern|Kirchner|Klose|Knoll|Konrad|Kopp|Kunz|Lenz|Lindemann|Lutz|Mann|Maurer|Menzel|Michel|Mohr|Moser|Nagel|Nolte|
Oswald|Petersen|Pfeifer|Popp|Preuß|Rauch|Reinhardt|Riedel|Rieger|Ruf|Sander|Schade|Scherer|Schindler|Schott|Schreiner|Schuh|Seifert|Siebert|Singer|
Stahl|Steffen|Steiner|Stephan|Strauß|Thiele|Ulrich|Unger|Vollmer|Walther|Weis|Weise|Wenzel|Wiese|Wilhelm|Witt|Wittmann|Wolter|Wulf|Zander|
Adam|Arndt|Barth|Baum|Behrens|Benz|Bernhardt|Beyer|Blum|Bock|Bode|Brand|Brückner|Burger|Decker|Dietz|Döring|Eberhardt|Ehlers|Erdmann|
Feldmann|Fleischer|Förster|Gärtner|Grimm|Haase|Hauser|Heck|Heller|Henning|Hennig|Hinz|Hofer|Holz|Jahn|John|Kessler|Kiefer|Klaus|Klemm|
Körner|Kranz|Krebs|Landgraf|Langer|Lauer|Lehner|Löffler|Martens|Mertens|Metz|Meißner|Merz|Münch|Naumann|Neubauer|Neuhaus|Niemann|Oppermann|Ott|
Pape|Pietsch|Rademacher|Rau|Reich|Rose|Rothe|Rudolph|Runge|Sachs|Schiller|Schlegel|Schön|Schramm|Schröter|Schweizer|Sievers|Springer|Stark|Stoll|
Straub|Timm|Urban|Völker|Weidner|Weigel|Weiss|Westphal|Wiedemann|Wiegand|Will|Winkelmann|Wirth|Wolters|Zeller|Zimmer|Abel|Ackermann|Bader|Bartels|
Bauer|Baumgartner|Bayer|Beckmann|Bender|Berndt|Bertram|Biermann|Bleich|Bohn|Brauer|Breuer|Buck|Dahmen|Daum|Dreher|Ebeling|Engelhardt|Faber|Fey|
Fischbach|Frick|Fröhlich|Funk|Gerber|Giese|Gottschalk|Gruber|Grün|Haag|Haller|Hanke|Hauck|Heim|Herold|Hildebrandt|Höhne|Hornung|Imhof|Jordan|
Kampmann|Karl|Kasper|Kemper|Kling|Knapp|Köster|Kretschmer|Kühne|Lindner|Link|Lohmann|Maas|Marquardt|Matthes|Mayr|Merkel|Mütze|Nickel|Oertel$$);

CALL fk_add_words('de_DE', 'title_M', 'Herr^100');
CALL fk_add_words('de_DE', 'title_F', 'Frau^100');
CALL fk_add_words('de_DE', 'academic', 'Dr.^60|Prof. Dr.^12|Dipl.-Ing.^12|Dr. med.^8|Dr. rer. nat.^4|Prof.^4');

-- Name layouts. Placeholders: {first} {middle} {mi} {last} {last2} {title} {acad}
CALL fk_add_words('de_DE', 'fmt_name', $$
{first} {last}^55|{title} {first} {last}^10|{first} {middle} {last}^10|{first}-{middle} {last}^5|
{acad} {first} {last}^8|{title} {acad} {first} {last}^4|{first} {last}-{last2}^5|{title} {last}^1|{last}, {first}^2$$);

-- -------------------------------------------------------------- address
-- street_name + street_suffix are glued together: 'Linden' + 'straße' = 'Lindenstraße'
CALL fk_add_words('de_DE', 'street_name', $$
Haupt|Bahnhof|Schul|Garten|Dorf|Kirch|Berg|Wald|Linden|Birken|Eichen|Buchen|Ahorn|Kastanien|Tannen|Rosen|Tulpen|Nelken|Mühlen|Wiesen|
Feld|Sonnen|Brunnen|Burg|Schloss|Markt|Rathaus|Post|Industrie|Gewerbe|Friedhof|Sport|Park|See|Bach|Hafen|Brücken|Tal|Goethe|Schiller|
Lessing|Heine|Beethoven|Mozart|Wagner|Brahms|Händel|Kant|Hegel|Luther|Bismarck|Humboldt|Kepler|Gauß|Röntgen|Einstein|Planck|Diesel|Daimler|Benz|
Bosch|Siemens|Gutenberg|Dürer|Holbein|Uhland|Herder|Wieland|Fontane|Storm|Eichendorff|Hölderlin|Novalis|Mörike|Hebel|Kleist|Brecht|Hesse|Kafka|Adenauer|
Ebert|Stresemann|Rathenau|Stauffenberg|Scholl|Kolping|Kopernikus|Leibniz|Liebig|Virchow|Amsel|Drossel|Finken|Lerchen|Meisen|Schwalben|Falken|Adler|Hirsch|Fuchs|
Hasen|Kloster|Kapellen|Turm|Tor|Graben|Wall|Anger|Heide|Moor|Wein|Hopfen|Korn|Apfel|Kirsch|Pappel|Erlen|Weiden|Eschen|Ulmen|
Fichten|Kiefern|Lärchen|Holunder|Flieder|Veilchen|Lilien|Dahlien|Astern|Rhein|Main|Donau|Elb|Weser|Neckar|Mosel|Isar|Oder|Saar|Ruhr|
Alpen|Harz|Eifel|Taunus|Schwarzwald|Odenwald|Spessart|Rhön|Nord|Süd|Ost|West|Mittel|Ober|Unter|Alt|Neu|Hoch|Stern|Friedens|
Freiheits|Schützen|Jäger|Fischer|Bäcker|Gerber|Bauern|Hirten|Grenz|Kanal|Deich|Quellen|Schäfer|Pfarr|Bürger|Rats|Königs|Kaiser|Fürsten|Grafen|
Herzog|Prinzen|Ritter|Kreuz|Lager|Mühlbach|Hecken|Wingert|Steinbruch|Ziegel$$);

CALL fk_add_words('de_DE', 'street_suffix', 'straße^50|weg^20|allee^5|platz^5|ring^5|gasse^5|damm^3|steig^2|pfad^2|ufer^2|stieg^1');
-- adjective + separate street type: 'Berliner Straße'
CALL fk_add_words('de_DE', 'street_adj', $$
Berliner|Hamburger|Münchner|Frankfurter|Kölner|Bremer|Leipziger|Dresdner|Stuttgarter|Nürnberger|Mainzer|Bonner|Kasseler|Potsdamer|Lübecker|Kieler|Rostocker|Erfurter|Magdeburger|Augsburger|
Würzburger|Heidelberger|Freiburger|Alte|Neue|Lange|Hohe|Breite|Obere|Untere$$);
CALL fk_add_words('de_DE', 'street_type', 'Straße^60|Allee^10|Landstraße^10|Chaussee^5|Weg^10|Ring^5');
-- full street names that are not built from parts
CALL fk_add_words('de_DE', 'street_full', $$
Am Markt|Am Rathaus|Am Bahnhof|Am Anger|An der Kirche|An der Mühle|Im Winkel|Im Grund|Auf dem Berg|Zur Linde|Hinter den Gärten|Unter den Linden|Am Sportplatz|
Am Wasserturm|An der Post|Im Wiesengrund|Am Hang|Am Schlosspark|In der Aue|Zum See|Am Mühlbach|Auf der Höhe|Im Eichengrund|An den Weiden|Am Kirchberg|Zur Alten Schmiede$$);
CALL fk_add_words('de_DE', 'house_number', '@^30|@#^58|@##^12');
CALL fk_add_words('de_DE', 'house_letter', 'a^50|b^30|c^15|d^5');

-- Placeholders: {street} {suffix} {adj} {type} {full} {number} {letter} {zip} {city} {state} {state_code}
CALL fk_add_words('de_DE', 'fmt_address', $$
{street}{suffix} {number}, {zip} {city}^45|
{street}{suffix} {number}{letter}, {zip} {city}^10|
{adj} {type} {number}, {zip} {city}^15|
{full} {number}, {zip} {city}^10|
{street}{suffix} {number}, {zip} {city}, {state}^8|
{street}{suffix} {number}, D-{zip} {city}^4|
{adj} {type} {number}{letter}, {zip} {city}, {state}^4|
{street}{suffix} {number} / {letter}, {zip} {city}^4$$);

CALL fk_add_cities('de_DE', $$
Berlin|Berlin|BE|1####|8;Hamburg|Hamburg|HH|2####|5;München|Bayern|BY|8####|4;Köln|Nordrhein-Westfalen|NW|50###|3;Frankfurt am Main|Hessen|HE|60###|2.5;
Stuttgart|Baden-Württemberg|BW|70###|2;Düsseldorf|Nordrhein-Westfalen|NW|40###|2;Leipzig|Sachsen|SN|04###|2;Dortmund|Nordrhein-Westfalen|NW|44###|2;Essen|Nordrhein-Westfalen|NW|45###|2;
Bremen|Bremen|HB|28###|2;Dresden|Sachsen|SN|01###|2;Hannover|Niedersachsen|NI|30###|2;Nürnberg|Bayern|BY|90###|2;Duisburg|Nordrhein-Westfalen|NW|47###|1.5;
Bochum|Nordrhein-Westfalen|NW|44###|1.5;Wuppertal|Nordrhein-Westfalen|NW|42###|1.5;Bielefeld|Nordrhein-Westfalen|NW|33###|1.5;Bonn|Nordrhein-Westfalen|NW|53###|1.5;Münster|Nordrhein-Westfalen|NW|48###|1.5;
Mannheim|Baden-Württemberg|BW|68###;Karlsruhe|Baden-Württemberg|BW|76###;Augsburg|Bayern|BY|86###;Wiesbaden|Hessen|HE|65###;Mönchengladbach|Nordrhein-Westfalen|NW|41###;
Gelsenkirchen|Nordrhein-Westfalen|NW|45###;Aachen|Nordrhein-Westfalen|NW|52###;Braunschweig|Niedersachsen|NI|38###;Chemnitz|Sachsen|SN|09###;Kiel|Schleswig-Holstein|SH|24###;
Halle (Saale)|Sachsen-Anhalt|ST|06###;Magdeburg|Sachsen-Anhalt|ST|39###;Freiburg im Breisgau|Baden-Württemberg|BW|79###;Krefeld|Nordrhein-Westfalen|NW|47###;Mainz|Rheinland-Pfalz|RP|55###;
Lübeck|Schleswig-Holstein|SH|23###;Erfurt|Thüringen|TH|99###;Oberhausen|Nordrhein-Westfalen|NW|46###;Rostock|Mecklenburg-Vorpommern|MV|18###;Kassel|Hessen|HE|34###;
Hagen|Nordrhein-Westfalen|NW|58###;Potsdam|Brandenburg|BB|14###;Saarbrücken|Saarland|SL|66###;Hamm|Nordrhein-Westfalen|NW|59###;Ludwigshafen am Rhein|Rheinland-Pfalz|RP|67###;
Oldenburg|Niedersachsen|NI|26###;Mülheim an der Ruhr|Nordrhein-Westfalen|NW|45###;Osnabrück|Niedersachsen|NI|49###;Leverkusen|Nordrhein-Westfalen|NW|51###;Darmstadt|Hessen|HE|64###;
Heidelberg|Baden-Württemberg|BW|69###;Solingen|Nordrhein-Westfalen|NW|42###;Herne|Nordrhein-Westfalen|NW|44###;Regensburg|Bayern|BY|93###;Neuss|Nordrhein-Westfalen|NW|41###;
Paderborn|Nordrhein-Westfalen|NW|33###;Ingolstadt|Bayern|BY|85###;Offenbach am Main|Hessen|HE|63###;Fürth|Bayern|BY|90###;Würzburg|Bayern|BY|97###;
Ulm|Baden-Württemberg|BW|89###;Heilbronn|Baden-Württemberg|BW|74###;Pforzheim|Baden-Württemberg|BW|75###;Wolfsburg|Niedersachsen|NI|38###;Göttingen|Niedersachsen|NI|37###;
Bottrop|Nordrhein-Westfalen|NW|46###;Reutlingen|Baden-Württemberg|BW|72###;Koblenz|Rheinland-Pfalz|RP|56###;Bremerhaven|Bremen|HB|27###;Recklinghausen|Nordrhein-Westfalen|NW|45###;
Erlangen|Bayern|BY|91###;Bergisch Gladbach|Nordrhein-Westfalen|NW|51###;Remscheid|Nordrhein-Westfalen|NW|42###;Jena|Thüringen|TH|07###;Trier|Rheinland-Pfalz|RP|54###;
Salzgitter|Niedersachsen|NI|38###;Moers|Nordrhein-Westfalen|NW|47###;Siegen|Nordrhein-Westfalen|NW|57###;Hildesheim|Niedersachsen|NI|31###;Cottbus|Brandenburg|BB|03###;
Kaiserslautern|Rheinland-Pfalz|RP|67###;Gütersloh|Nordrhein-Westfalen|NW|33###;Schwerin|Mecklenburg-Vorpommern|MV|19###;Witten|Nordrhein-Westfalen|NW|58###;Gera|Thüringen|TH|07###;
Iserlohn|Nordrhein-Westfalen|NW|58###;Ludwigsburg|Baden-Württemberg|BW|71###;Hanau|Hessen|HE|63###;Esslingen am Neckar|Baden-Württemberg|BW|73###;Zwickau|Sachsen|SN|08###;
Düren|Nordrhein-Westfalen|NW|52###;Ratingen|Nordrhein-Westfalen|NW|40###;Flensburg|Schleswig-Holstein|SH|24###;Lünen|Nordrhein-Westfalen|NW|44###;Villingen-Schwenningen|Baden-Württemberg|BW|78###;
Konstanz|Baden-Württemberg|BW|78###;Marl|Nordrhein-Westfalen|NW|45###;Worms|Rheinland-Pfalz|RP|67###;Velbert|Nordrhein-Westfalen|NW|42###;Minden|Nordrhein-Westfalen|NW|32###;
Neumünster|Schleswig-Holstein|SH|24###;Dessau-Roßlau|Sachsen-Anhalt|ST|06###;Norderstedt|Schleswig-Holstein|SH|22###;Delmenhorst|Niedersachsen|NI|27###;Bamberg|Bayern|BY|96###;
Viersen|Nordrhein-Westfalen|NW|41###;Marburg|Hessen|HE|35###;Rheine|Nordrhein-Westfalen|NW|48###;Wilhelmshaven|Niedersachsen|NI|26###;Lüneburg|Niedersachsen|NI|21###;
Gladbeck|Nordrhein-Westfalen|NW|45###;Troisdorf|Nordrhein-Westfalen|NW|53###;Bayreuth|Bayern|BY|95###;Dorsten|Nordrhein-Westfalen|NW|46###;Detmold|Nordrhein-Westfalen|NW|32###;
Passau|Bayern|BY|94###;Rosenheim|Bayern|BY|83###;Landshut|Bayern|BY|84###;Weimar|Thüringen|TH|99###;Görlitz|Sachsen|SN|02###;
Stralsund|Mecklenburg-Vorpommern|MV|18###;Greifswald|Mecklenburg-Vorpommern|MV|17###;Frankfurt (Oder)|Brandenburg|BB|15###;Brandenburg an der Havel|Brandenburg|BB|14###;Kempten (Allgäu)|Bayern|BY|87###;
Garmisch-Partenkirchen|Bayern|BY|82###;Baden-Baden|Baden-Württemberg|BW|76###;Tübingen|Baden-Württemberg|BW|72###;Fulda|Hessen|HE|36###;Gießen|Hessen|HE|35###$$);

-- ------------------------------------------------------- phone & e-mail
CALL fk_add_words('de_DE', 'fmt_phone', $$
0%## #######^14|0%### ######^12|0%#/#######^6|(0%##) ######^8|+49 %## #######^10|+49 (0)%## ######^6|0%##-######^6|
015# ########^8|016# #######^5|017# #######^8|+49 15# ########^4|+49 17# #######^5|0%## / ## ## ##^4|+49%#########^2$$);

CALL fk_add_words('de_DE', 'fmt_email', $$
{first}.{last}^25|{first}{last}^10|{f}.{last}^12|{first}.{last}{nn}^10|{first}_{last}^6|{last}.{first}^6|{first}{yy}^6|{f}{last}{nnn}^5|{last}{nn}^4|{first}-{last}^6$$);
CALL fk_add_words('de_DE', 'email_domain', $$
gmx.de^20|web.de^20|t-online.de^14|gmail.com^15|gmx.net^6|freenet.de^5|outlook.de^5|yahoo.de^5|posteo.de^3|mail.de^3|arcor.de^3|online.de^2|icloud.com^2$$);

-- ------------------------------------------------- physical attributes
CALL fk_add_words('de_DE', 'eye_color', 'Blau^35|Braun^30|Grün^12|Grau^10|Haselnussbraun^8|Bernstein^3|Zweifarbig^0.5');
CALL fk_add_words('de_DE', 'hair_color', 'Braun^30|Dunkelblond^20|Blond^15|Schwarz^12|Rot^4|Kastanienbraun^5|Grau^8|Weiß^3|Glatze^3');
CALL fk_add_words('de_DE', 'blood_type', 'A+^37|0+^35|B+^9|AB+^4|A-^6|0-^6|B-^2|AB-^1');

INSERT INTO distributions (locale, attribute, gender, mean, sd, min_value, max_value) VALUES
    ('de_DE', 'height_cm', 'M', 179.9, 7.0, 150, 215),
    ('de_DE', 'height_cm', 'F', 166.1, 6.6, 140, 200),
    ('de_DE', 'bmi',       'M', 27.0,  4.2, 16,  48),
    ('de_DE', 'bmi',       'F', 25.5,  5.0, 16,  48),
    ('de_DE', 'age',       'M', 44,    17,  18,  95),
    ('de_DE', 'age',       'F', 46,    18,  18,  99)
ON CONFLICT DO NOTHING;

-- ------------------------------------------------------- markov corpus
INSERT INTO text_corpus (locale, body) VALUES ('de_DE', $$
Ich bin in einem kleinen Dorf in der Nähe von Freiburg aufgewachsen. Jeden Morgen ging mein Vater zum Bäcker an der Ecke und kam mit frischen Brötchen und den neuesten Geschichten zurück. Die Geschichten waren selten wichtig, aber sie wurden immer mit großer Begeisterung erzählt. Meine Mutter arbeitete in der Bibliothek und glaubte, dass man jedes Problem mit dem richtigen Buch lösen kann. Meistens hatte sie recht. Im Sommer fuhren wir an den See und verbrachten lange Nachmittage mit Schwimmen, Lesen und Streiten über nichts Besonderes. Das Wasser war kalt, die Brote waren weich, und ich würde diese Tage gegen nichts eintauschen.

Heute arbeite ich als Ingenieurin in einer großen Stadt. Ich löse gerne schwierige Aufgaben, aber ich vermisse manchmal die ruhigen Abende meiner Kindheit. Am Wochenende koche ich gerne für meine Freunde. Mein Lieblingsrezept ist eine Kartoffelsuppe, die den ganzen Nachmittag dauert und die Wohnung mit einem wunderbaren Duft erfüllt. Manche Leute sagen, dass Kochen eine Wissenschaft ist, aber ich finde, es ist eher wie Musik. Man folgt den Noten, und dann improvisiert man, wenn niemand hinschaut.

Ich mag alte Filme, lange Spaziergänge und starken Kaffee. Ich glaube, dass ein gutes Gespräch mehr wert ist als ein teures Abendessen. Meine Freunde beschreiben mich als geduldig, neugierig und ein bisschen stur. Seit drei Jahren lerne ich Gitarre und ich spiele immer noch schrecklich. Das hält mich aber nicht davon ab, jeden Abend zu üben. Meine Nachbarn sind sehr freundliche Menschen, oder vielleicht sind sie einfach sehr müde.

Letztes Jahr bin ich mit dem Zug durch ganz Deutschland gefahren. Ich habe eine pensionierte Lehrerin getroffen, die jeden Nationalpark besucht hatte, einen jungen Bauern, der Pilot werden wollte, und einen Musiker, der sein Klavier im Kopf trug. Jeder Fremde hatte eine Geschichte, und jede Geschichte machte die Reise kürzer. Als ich nach Hause kam, habe ich angefangen, diese Geschichten aufzuschreiben. Vielleicht wird eines Tages ein Buch daraus.

Samstags helfe ich im Tierheim. Die Hunde sind laut und die Katzen sind misstrauisch, aber sie sind alle auf eine Weise ehrlich, wie Menschen es selten sind. Ich finde, jeder sollte etwas Zeit mit Tieren verbringen, die Hilfe brauchen. Man lernt dabei, ohne Worte zuzuhören.

Mein Ziel für das nächste Jahr ist einfach. Ich möchte einen Marathon laufen, fünfzig Bücher lesen und endlich lernen, wie man Brot backt wie mein Vater. Ich weiß, dass es nicht leicht wird. Gute Dinge sind selten leicht. Aber ich habe gelernt, dass kleine Schritte jeden Tag einen überraschend weit bringen können, und dass eine Tasse Kaffee mit einem Freund fast jeden schlechten Morgen retten kann. Im Herbst wandere ich gerne durch den Schwarzwald, wenn die Blätter bunt werden und die Luft nach Regen riecht.
$$);
