-- =====================================================================
-- SQL Faker :: locale en_US (English / USA)
-- =====================================================================
INSERT INTO locales (code, name, units) VALUES ('en_US', 'English (USA)', 'imperial')
ON CONFLICT (code) DO NOTHING;

-- ---------------------------------------------------------------- names
CALL fk_add_words('en_US', 'first_name_M', $$
James|John|Robert|Michael|William|David|Richard|Joseph|Thomas|Charles|Christopher|Daniel|Matthew|Anthony|Mark|Donald|Steven|Paul|Andrew|Joshua|
Kenneth|Kevin|Brian|George|Timothy|Ronald|Edward|Jason|Jeffrey|Ryan|Jacob|Gary|Nicholas|Eric|Jonathan|Stephen|Larry|Justin|Scott|Brandon|
Benjamin|Samuel|Gregory|Alexander|Frank|Patrick|Raymond|Jack|Dennis|Jerry|Tyler|Aaron|Jose|Adam|Nathan|Henry|Douglas|Zachary|Peter|Kyle|
Ethan|Walter|Noah|Jeremy|Christian|Keith|Roger|Terry|Gerald|Harold|Sean|Austin|Carl|Arthur|Lawrence|Dylan|Jesse|Jordan|Bryan|Billy|
Joe|Bruce|Gabriel|Logan|Albert|Willie|Alan|Juan|Wayne|Elijah|Randy|Roy|Vincent|Ralph|Eugene|Russell|Bobby|Mason|Philip|Louis|
Harry|Howard|Fred|Liam|Oliver|Lucas|Levi|Isaac|Owen|Wyatt|Caleb|Hunter|Isaiah|Connor|Luke|Evan|Gavin|Carter|Jayden|Julian|
Landon|Cole|Chase|Ian|Adrian|Blake|Colton|Dominic|Xavier|Jaxon|Miles|Parker|Hudson|Brayden|Asher|Theodore|Leo|Ezra|Lincoln|Grayson|
Jace|Easton|Nolan|Cameron|Carlos|Luis|Miguel|Antonio|Victor|Marcus|Travis|Shawn|Derek|Cody|Corey|Trevor|Bradley|Craig|Todd|Glenn|
Curtis|Dale|Mitchell|Spencer|Wesley|Clayton|Garrett|Grant|Marshall|Neil|Calvin|Martin|Allen|Stanley|Leonard|Francis|Earl|Jimmy|Johnny|Clarence|
Darren|Dustin|Brett|Ross|Seth|Maxwell|Silas|Everett|Declan|Roman|Rowan|Sawyer|Bennett|Brooks|Emmett|Jasper|Harrison|Beau|Tucker|Preston|
Riley|Elliott|Max|Jude|Malcolm|Desmond|Quentin|Rodney|Herbert|Leon$$);

CALL fk_add_words('en_US', 'first_name_F', $$
Mary|Patricia|Jennifer|Linda|Elizabeth|Barbara|Susan|Jessica|Sarah|Karen|Lisa|Nancy|Betty|Margaret|Sandra|Ashley|Kimberly|Emily|Donna|Michelle|
Carol|Amanda|Dorothy|Melissa|Deborah|Stephanie|Rebecca|Sharon|Laura|Cynthia|Kathleen|Amy|Angela|Shirley|Anna|Brenda|Pamela|Emma|Nicole|Helen|
Samantha|Katherine|Christine|Debra|Rachel|Carolyn|Janet|Catherine|Maria|Heather|Diane|Ruth|Julie|Olivia|Joyce|Virginia|Victoria|Kelly|Lauren|Christina|
Joan|Evelyn|Judith|Megan|Andrea|Cheryl|Hannah|Jacqueline|Martha|Gloria|Teresa|Ann|Sara|Madison|Frances|Kathryn|Janice|Jean|Abigail|Alice|
Julia|Judy|Sophia|Grace|Denise|Amber|Doris|Marilyn|Danielle|Beverly|Isabella|Theresa|Diana|Natalie|Brittany|Charlotte|Marie|Kayla|Alexis|Lori|
Ava|Mia|Harper|Amelia|Ella|Avery|Scarlett|Aria|Chloe|Penelope|Layla|Lily|Zoey|Nora|Ellie|Stella|Hazel|Aurora|Violet|Savannah|
Audrey|Brooklyn|Bella|Claire|Skylar|Lucy|Paisley|Everly|Caroline|Naomi|Elena|Leah|Allison|Gabriella|Madelyn|Sadie|Ariana|Autumn|Quinn|Peyton|
Ruby|Eva|Serenity|Sophie|Willow|Kennedy|Taylor|Morgan|Jasmine|Erin|Molly|Vanessa|Monica|Erica|Tiffany|Crystal|Tina|Wendy|Holly|Courtney|
Lindsay|Kristen|Leslie|Dana|Tracy|Melanie|Valerie|Kristin|Jill|Gina|Paige|Sydney|Haley|Jenna|Kylie|Mackenzie|Alyssa|Brianna|Kaitlyn|Rose|
Jane|Lillian|Eleanor|Josephine|Clara|Margot|Iris|Ivy|Daisy|Lydia|Esther|Vivian|Norma|Irene|Peggy|Wanda|Bonnie|Joanne|Sherry|Rita|
Connie|Paula|Ellen|Carrie|Stacy|Renee|Faith|Hope|Miranda|Delilah$$);

CALL fk_add_words('en_US', 'last_name', $$
Smith|Johnson|Williams|Brown|Jones|Garcia|Miller|Davis|Rodriguez|Martinez|Hernandez|Lopez|Gonzalez|Wilson|Anderson|Thomas|Taylor|Moore|Jackson|Martin|
Lee|Perez|Thompson|White|Harris|Sanchez|Clark|Ramirez|Lewis|Robinson|Walker|Young|Allen|King|Wright|Scott|Torres|Nguyen|Hill|Flores|
Green|Adams|Nelson|Baker|Hall|Rivera|Campbell|Mitchell|Carter|Roberts|Gomez|Phillips|Evans|Turner|Diaz|Parker|Cruz|Edwards|Collins|Reyes|
Stewart|Morris|Morales|Murphy|Cook|Rogers|Gutierrez|Ortiz|Morgan|Cooper|Peterson|Bailey|Reed|Kelly|Howard|Ramos|Kim|Cox|Ward|Richardson|
Watson|Brooks|Chavez|Wood|James|Bennett|Gray|Mendoza|Ruiz|Hughes|Price|Alvarez|Castillo|Sanders|Patel|Myers|Long|Ross|Foster|Jimenez|
Powell|Jenkins|Perry|Russell|Sullivan|Bell|Coleman|Butler|Henderson|Barnes|Gonzales|Fisher|Vasquez|Simmons|Romero|Jordan|Patterson|Alexander|Hamilton|Graham|
Reynolds|Griffin|Wallace|Moreno|West|Cole|Hayes|Bryant|Herrera|Gibson|Ellis|Tran|Medina|Aguilar|Stevens|Murray|Ford|Castro|Marshall|Owens|
Harrison|Fernandez|McDonald|Woods|Washington|Kennedy|Wells|Vargas|Henry|Chen|Freeman|Webb|Tucker|Guzman|Burns|Crawford|Olson|Simpson|Porter|Hunter|
Gordon|Mendez|Silva|Shaw|Snyder|Mason|Dixon|Munoz|Hunt|Hicks|Holmes|Palmer|Wagner|Black|Robertson|Boyd|Rose|Stone|Salazar|Fox|
Warren|Mills|Meyer|Rice|Schmidt|Garza|Daniels|Ferguson|Nichols|Stephens|Soto|Weaver|Ryan|Gardner|Payne|Grant|Dunn|Kelley|Spencer|Hawkins|
Arnold|Pierce|Vazquez|Hansen|Peters|Santos|Hart|Bradley|Knight|Elliott|Cunningham|Duncan|Armstrong|Hudson|Carroll|Lane|Riley|Andrews|Alvarado|Ray|
Delgado|Berry|Perkins|Hoffman|Johnston|Matthews|Pena|Richards|Contreras|Willis|Carpenter|Lawrence|Sandoval|Guerrero|George|Chapman|Rios|Estrada|Ortega|Watkins|
Greene|Nunez|Wheeler|Valdez|Harper|Burke|Larson|Santiago|Maldonado|Morrison|Franklin|Carlson|Austin|Dominguez|Carr|Lawson|Jacobs|O'Brien|Lynch|Singh|
Vega|Bishop|Montgomery|Oliver|Jensen|Harvey|Williamson|Gilbert|Dean|Sims|Espinoza|Howell|Li|Wong|Reid|Hanson|Le|McCoy|Garrett|Burton|
Fuller|Wang|Weber|Welch|Rojas|Lucas|Marquez|Fields|Park|Yang|Little|Banks|Padilla|Day|Walsh|Bowman|Schultz|Luna|Fowler|Mejia|
Davidson|Acosta|Brewer|May|Holland|Juarez|Newman|Pearson|Curtis|Cortez|Douglas|Schneider|Joseph|Barrett|Navarro|Figueroa|Keller|Avila|Wade|Molina|
Stanley|Hopkins|Campos|Barnett|Bates|Chambers|Caldwell|Beck|Lambert|Miranda|Byrd|Craig|Ayala|Lowe|Frazier|Powers|Neal|Leonard|Gregory|Carrillo|
Sutton|Fleming|Rhodes|Shelton|Schwartz|Norris|Jennings|Watts|Duran|Walters|Cohen|McDaniel|Moran|Parks|Steele|Vaughn|Becker|Holt|DeLeon|Barker|
Terry|Hale|Leon|Benson|Haynes|Horton|Miles|Lyons|Pham|Graves|Bush|Thornton|Wolfe|Warner|Cabrera|McKinney|Mann|Zimmerman|Dawson|Lara|
Fletcher|Page|McCarthy|Love|Robles|Cervantes|Solis|Erickson|Reeves|Chang|Klein|Salinas|Fuentes|Baldwin|Daniel|Simon|Velasquez|Hardy|Higgins|Aguirre|
Lin|Cummings|Chandler|Sharp|Barber|Bowen|Ochoa|Dennis|Robbins|Liu|Ramsey|Francis|Griffith|Paul|Blair|O'Connor|Cardenas|Pacheco|Cross|Calderon|
Quinn|Moss|Swanson|Chan|Rivas|Khan|Rodgers|Serrano|Fitzgerald|Rosales|Stevenson|Christensen|Manning|Gill|Curry|McLaughlin|Harmon|McGee|Gross|Doyle|
Garner|Newton|Burgess|Reese|Walton|Blake|Trujillo|Adkins|Brady|Goodman|Roman|Webster|Goodwin|Fischer|Huang|Potter|Delacruz|Montoya|Todd|Wu|
Hines|Mullins|Castaneda|Malone|Cannon|Tate|Mack|Sherman|Hubbard|Hodges|Zhang|Guerra|Wolf|Valencia|Saunders|Franco|Rowe|Gallagher|Farmer|Hammond|
Hampton|Townsend|Ingram|Wise|Gallegos|Clarke|Barton|Schroeder|Maxwell|Waters|Logan|Camacho|Strickland|Norman|Person|Colon|Parsons|Frank|Harrington|Glover|
Osborne|Buchanan|Casey|Floyd|Patton|Ibarra|Ball|Tyler|Suarez|Bowers|Orozco|Salas|Cobb|Gibbs|Andrade|Bauer|Conner|Moody|Escobar|McGuire|
Lloyd|Mueller|Hartman|French|Kramer|McBride|Pope|Lindsey|Velazquez|Norton|McCormick|Sparks|Flynn|Yates|Hogan|Marsh|Macias|Villanueva|Zamora|Pratt|
Stokes|Owen|Ballard|Lang|Brock|Villarreal|Charles|Drake|Barrera|Cain|Patrick|Pineda|Burnett|Mercado|Santana|Shepherd|Bautista|Ali|Shaffer|Lamb|
Trevino|McKenzie|Hess|Beil|Olsen|Cochran|Morton|Nash|Wilkins|Petersen|Briggs|Shah|Roth|Nicholson|Holloway|Lozano|Rangel|Flowers|Hoover|Short$$);

CALL fk_add_words('en_US', 'title_M', 'Mr.^85|Dr.^10|Prof.^3|Rev.^2');
CALL fk_add_words('en_US', 'title_F', 'Ms.^50|Mrs.^30|Miss^8|Dr.^9|Prof.^3');
CALL fk_add_words('en_US', 'suffix_M', 'Jr.^50|Sr.^20|II^12|III^10|IV^3|PhD^3|MD^2');
CALL fk_add_words('en_US', 'suffix_F', 'PhD^45|MD^35|DDS^10|Esq.^10');

-- Name layouts. Placeholders: {first} {middle} {mi} {last} {last2} {title} {acad} {suffix}
CALL fk_add_words('en_US', 'fmt_name', $$
{first} {last}^50|{first} {mi}. {last}^15|{first} {middle} {last}^8|{title} {first} {last}^10|
{title} {first} {mi}. {last}^5|{first} {last} {suffix}^4|{first} {mi}. {last} {suffix}^2|{title} {last}, {first}^1|
{first} {last}-{last2}^2|{last}, {first} {mi}.^3$$);

-- -------------------------------------------------------------- address
CALL fk_add_words('en_US', 'street_name', $$
Main|Oak|Pine|Maple|Cedar|Elm|Washington|Lake|Hill|Park|Walnut|Spruce|Sunset|Ridge|Highland|Church|Mill|River|Forest|Meadow|
Spring|Willow|Jackson|Lincoln|Jefferson|Madison|Franklin|Adams|Monroe|Wilson|Center|Union|Market|Water|Broad|School|North|South|Valley|Chestnut|
Birch|Hickory|Dogwood|Magnolia|Poplar|Sycamore|Laurel|Holly|Juniper|Aspen|Cherry|Peach|Orchard|Garden|Prospect|Pleasant|Liberty|Railroad|Bridge|Front|
High|King|Queen|Prince|Court|College|Academy|Lafayette|Grant|Hamilton|Clinton|Taylor|Harrison|Cleveland|Kennedy|Roosevelt|Hawthorne|Woodland|Fairview|Lakeview|
Riverside|Hillcrest|Brookside|Greenwood|Oakwood|Pinecrest|Rosewood|Briarwood|Cottonwood|Sherwood|Westwood|Eastwood|Kingston|Arlington|Ashland|Belmont|Cambridge|Charleston|Chester|Dover|
Essex|Fulton|Georgetown|Hampton|Hanover|Kensington|Lexington|Manchester|Newport|Oxford|Princeton|Richmond|Salem|Stratford|Trenton|Windsor|Yorktown|Canyon|Mesa|Prairie|
Summit|Vista|Bayview|Harbor|Beach|Ocean|Shore|Bay|Creek|Brook|Glen|Grove|Heather|Ivy|Lilac|Daisy|Primrose|Rose|Sunflower|Tulip|
Violet|Jasmine|Clover|Fox|Deer|Eagle|Hawk|Falcon|Robin|Cardinal|Bluebird|Sparrow|Quail|Pheasant|Bear|Wolf|Elk|Buffalo|Mustang|Colonial|
Heritage|Pioneer|Frontier|Patriot|Independence|Constitution|Victory|Commerce|Industrial|Airport|Station|Depot|Ferry|Dock|Mountain|Rocky|Granite|Stone|Boulder|Cobblestone|
Sandstone|Silver|Golden|Copper|Iron|Crystal|Diamond|Emerald|Sapphire|Pearl|Amber|Autumn|Winter|Summer|Evergreen|Wildwood|Timber|Lone Pine|Twin Oaks|Old Mill|
Country Club|Shady|Hidden|First|Second|Third|Fourth|Fifth|Sixth|Seventh|Eighth|Ninth|Tenth|Eleventh|Twelfth$$);

CALL fk_add_words('en_US', 'street_suffix', $$
Street^20|St^12|Avenue^12|Ave^8|Road^8|Rd^5|Drive^8|Dr^4|Lane^6|Ln^3|Boulevard^3|Blvd^2|Court^4|Ct^2|Way^4|Place^3|Circle^2|Terrace^2|Parkway^2|Trail^2|Highway^1|Loop^1$$);
CALL fk_add_words('en_US', 'street_dir', 'N|S|E|W|North|South|East|West|NE|NW|SE|SW');
CALL fk_add_words('en_US', 'house_number', '@^10|@#^25|@##^35|@###^25|@####^5');
CALL fk_add_words('en_US', 'unit', 'Apt. @^20|Apt. @#^20|Apt. @##^15|Suite @##^15|Unit @^10|Unit @#^10|Fl. @^5|Rm. @##^5');

-- Placeholders: {number} {street} {suffix} {dir} {unit} {city} {state} {state_code} {zip}
CALL fk_add_words('en_US', 'fmt_address', $$
{number} {street} {suffix}, {city}, {state_code} {zip}^45|
{number} {street} {suffix}, {unit}, {city}, {state_code} {zip}^20|
{number} {dir} {street} {suffix}, {city}, {state_code} {zip}^12|
{number} {street} {suffix} {unit}, {city}, {state} {zip}^8|
{number} {dir} {street} {suffix}, {unit}, {city}, {state_code} {zip}^6|
{number} {street} {suffix}, {city}, {state} {zip}^5|
PO Box {number}, {city}, {state_code} {zip}^4$$);

CALL fk_add_cities('en_US', $$
New York|New York|NY|100##|8;Los Angeles|California|CA|900##|5;Chicago|Illinois|IL|606##|4;Houston|Texas|TX|770##|3;Phoenix|Arizona|AZ|850##|2;
Philadelphia|Pennsylvania|PA|191##|2;San Antonio|Texas|TX|782##|2;San Diego|California|CA|921##|2;Dallas|Texas|TX|752##|2;San Jose|California|CA|951##|2;
Austin|Texas|TX|787##|2;Jacksonville|Florida|FL|322##|1.5;Fort Worth|Texas|TX|761##|1.5;Columbus|Ohio|OH|432##|1.5;Charlotte|North Carolina|NC|282##|1.5;
San Francisco|California|CA|941##|1.5;Indianapolis|Indiana|IN|462##|1.5;Seattle|Washington|WA|981##|1.5;Denver|Colorado|CO|802##|1.5;Washington|District of Columbia|DC|200##|1.5;
Boston|Massachusetts|MA|021##|1.5;El Paso|Texas|TX|799##;Nashville|Tennessee|TN|372##;Detroit|Michigan|MI|482##;Oklahoma City|Oklahoma|OK|731##;
Portland|Oregon|OR|972##;Las Vegas|Nevada|NV|891##;Memphis|Tennessee|TN|381##;Louisville|Kentucky|KY|402##;Baltimore|Maryland|MD|212##;
Milwaukee|Wisconsin|WI|532##;Albuquerque|New Mexico|NM|871##;Tucson|Arizona|AZ|857##;Fresno|California|CA|937##;Sacramento|California|CA|958##;
Kansas City|Missouri|MO|641##;Mesa|Arizona|AZ|852##;Atlanta|Georgia|GA|303##;Omaha|Nebraska|NE|681##;Colorado Springs|Colorado|CO|809##;
Raleigh|North Carolina|NC|276##;Miami|Florida|FL|331##;Long Beach|California|CA|908##;Virginia Beach|Virginia|VA|234##;Oakland|California|CA|946##;
Minneapolis|Minnesota|MN|554##;Tulsa|Oklahoma|OK|741##;Tampa|Florida|FL|336##;Arlington|Texas|TX|760##;New Orleans|Louisiana|LA|701##;
Wichita|Kansas|KS|672##;Cleveland|Ohio|OH|441##;Bakersfield|California|CA|933##;Aurora|Colorado|CO|800##;Anaheim|California|CA|928##;
Honolulu|Hawaii|HI|968##;Santa Ana|California|CA|927##;Riverside|California|CA|925##;Corpus Christi|Texas|TX|784##;Lexington|Kentucky|KY|405##;
Stockton|California|CA|952##;Henderson|Nevada|NV|890##;Saint Paul|Minnesota|MN|551##;St. Louis|Missouri|MO|631##;Cincinnati|Ohio|OH|452##;
Pittsburgh|Pennsylvania|PA|152##;Greensboro|North Carolina|NC|274##;Anchorage|Alaska|AK|995##;Plano|Texas|TX|750##;Lincoln|Nebraska|NE|685##;
Orlando|Florida|FL|328##;Irvine|California|CA|926##;Newark|New Jersey|NJ|071##;Toledo|Ohio|OH|436##;Durham|North Carolina|NC|277##;
Chula Vista|California|CA|919##;Fort Wayne|Indiana|IN|468##;Jersey City|New Jersey|NJ|073##;St. Petersburg|Florida|FL|337##;Laredo|Texas|TX|780##;
Madison|Wisconsin|WI|537##;Chandler|Arizona|AZ|852##;Buffalo|New York|NY|142##;Lubbock|Texas|TX|794##;Scottsdale|Arizona|AZ|852##;
Reno|Nevada|NV|895##;Glendale|Arizona|AZ|853##;Gilbert|Arizona|AZ|852##;Winston-Salem|North Carolina|NC|271##;North Las Vegas|Nevada|NV|890##;
Norfolk|Virginia|VA|235##;Chesapeake|Virginia|VA|233##;Garland|Texas|TX|750##;Irving|Texas|TX|750##;Hialeah|Florida|FL|330##;
Fremont|California|CA|945##;Boise|Idaho|ID|837##;Richmond|Virginia|VA|232##;Baton Rouge|Louisiana|LA|708##;Spokane|Washington|WA|992##;
Des Moines|Iowa|IA|503##;Tacoma|Washington|WA|984##;San Bernardino|California|CA|924##;Modesto|California|CA|953##;Fontana|California|CA|923##;
Santa Clarita|California|CA|913##;Birmingham|Alabama|AL|352##;Oxnard|California|CA|930##;Fayetteville|North Carolina|NC|283##;Moreno Valley|California|CA|925##;
Rochester|New York|NY|146##;Glendale|California|CA|912##;Huntington Beach|California|CA|926##;Salt Lake City|Utah|UT|841##;Grand Rapids|Michigan|MI|495##;
Amarillo|Texas|TX|791##;Yonkers|New York|NY|107##;Aurora|Illinois|IL|605##;Montgomery|Alabama|AL|361##;Akron|Ohio|OH|443##;
Little Rock|Arkansas|AR|722##;Huntsville|Alabama|AL|358##;Augusta|Georgia|GA|309##;Columbus|Georgia|GA|319##;Grand Prairie|Texas|TX|750##;
Shreveport|Louisiana|LA|711##;Overland Park|Kansas|KS|662##;Tallahassee|Florida|FL|323##;Mobile|Alabama|AL|366##;Knoxville|Tennessee|TN|379##;
Worcester|Massachusetts|MA|016##;Providence|Rhode Island|RI|029##;Fort Lauderdale|Florida|FL|333##;Chattanooga|Tennessee|TN|374##;Tempe|Arizona|AZ|852##;
Burlington|Vermont|VT|054##;Portland|Maine|ME|041##;Manchester|New Hampshire|NH|031##;Hartford|Connecticut|CT|061##;Wilmington|Delaware|DE|198##;
Charleston|West Virginia|WV|253##;Charleston|South Carolina|SC|294##;Columbia|South Carolina|SC|292##;Jackson|Mississippi|MS|392##;Sioux Falls|South Dakota|SD|571##;
Fargo|North Dakota|ND|581##;Billings|Montana|MT|591##;Cheyenne|Wyoming|WY|820##;Savannah|Georgia|GA|314##;Ann Arbor|Michigan|MI|481##$$);

-- ------------------------------------------------------- phone & e-mail
-- '#' = 0-9, '@' = 1-9, '%' = 2-9 (NANP area codes / exchanges never start with 0 or 1)
CALL fk_add_words('en_US', 'fmt_phone', $$
(%##) %##-####^30|%##-%##-####^25|%##.%##.####^10|+1 %## %## ####^12|1-%##-%##-####^8|+1 (%##) %##-####^7|(%##) %##-#### x###^4|(%##) %##-#### ext. ##^2|%##%######^2$$);

-- Placeholders: {first} {last} {f} {l} {nn} {nnn} {yy}
CALL fk_add_words('en_US', 'fmt_email', $$
{first}.{last}^25|{first}{last}^12|{f}{last}^12|{first}.{last}{nn}^10|{first}_{last}^6|{last}.{first}^5|{first}{yy}^6|{f}.{last}{nnn}^5|{first}{l}^4|{last}{f}{nn}^4|{first}.{l}.{last}^2$$);
CALL fk_add_words('en_US', 'email_domain', $$
gmail.com^30|yahoo.com^14|outlook.com^10|hotmail.com^9|icloud.com^8|aol.com^5|comcast.net^4|verizon.net^3|att.net^3|live.com^3|msn.com^2|protonmail.com^2|mail.com^2|me.com^2|sbcglobal.net^2$$);

-- ------------------------------------------------- physical attributes
CALL fk_add_words('en_US', 'eye_color', 'Brown^45|Blue^27|Hazel^9|Green^9|Amber^5|Gray^3|Heterochromia^0.5');
CALL fk_add_words('en_US', 'hair_color', 'Brown^35|Black^25|Blonde^15|Dark Blonde^8|Auburn^5|Red^3|Gray^6|White^2|Bald^3');
CALL fk_add_words('en_US', 'blood_type', 'O+^37.4|A+^35.7|B+^8.5|AB+^3.4|O-^6.6|A-^6.3|B-^1.5|AB-^0.6');

INSERT INTO distributions (locale, attribute, gender, mean, sd, min_value, max_value) VALUES
    ('en_US', 'height_cm', 'M', 175.4, 7.6, 145, 215),
    ('en_US', 'height_cm', 'F', 161.5, 7.1, 135, 200),
    ('en_US', 'bmi',       'M', 28.5,  4.8, 16,  50),
    ('en_US', 'bmi',       'F', 28.0,  5.8, 16,  50),
    ('en_US', 'age',       'M', 42,    16,  18,  95),
    ('en_US', 'age',       'F', 44,    17,  18,  99)
ON CONFLICT DO NOTHING;

-- ------------------------------------------------------- markov corpus
INSERT INTO text_corpus (locale, body) VALUES ('en_US', $$
I grew up in a small town where everybody knew the name of your dog. Every morning my father walked to the bakery on the corner and came back with warm bread and the latest news. The news was rarely important, but it was always told with great enthusiasm. My mother worked at the library and believed that every problem could be solved with the right book. She was usually correct. In the summer we drove to the lake and spent long afternoons fishing, reading and arguing about nothing in particular. The water was cold, the sandwiches were soggy, and I would not trade those days for anything.

Today I work as a software engineer in a busy city. I enjoy solving problems, but I still miss the quiet evenings of my childhood. On weekends I like to cook for my friends. My favorite recipe is a slow tomato soup that takes the whole afternoon and fills the apartment with a wonderful smell. Some people say that cooking is a science, but I think it is closer to music. You follow the notes, and then you improvise when nobody is watching.

I am a big fan of old movies, long walks and strong coffee. I believe that a good conversation is worth more than an expensive dinner. My friends describe me as patient, curious and a little bit stubborn. I have been learning to play the guitar for three years and I am still terrible at it. That does not stop me from playing every night. My neighbors are very kind people, or perhaps they are simply very tired.

Last year I traveled across the country by train. I met a retired teacher who had visited every national park, a young farmer who wanted to become a pilot, and a musician who carried his piano in his head. Every stranger had a story, and every story made the journey shorter. When I came home I started writing those stories down. Maybe one day they will become a book.

I volunteer at the animal shelter on Saturdays. The dogs are loud and the cats are suspicious, but they are all honest in a way that people rarely are. I think everybody should spend some time with animals that need help. It teaches you to listen without words.

My goal for next year is simple. I want to run a marathon, read fifty books and finally learn how to bake bread like my father. I know that it will not be easy. Good things rarely are. But I have learned that small steps every day can take you surprisingly far, and that a cup of coffee with a friend can fix almost any bad morning.
$$);
