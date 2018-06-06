const fs = require('fs');
const path = require('path');
const http = require('http');
const _ = require('underscore')

const testdir = '/Users/jaywright/Desktop/Development/Lexografik/LexografikTests';

const testHeader = 'func test';
const wordHeader = 'XCTAssertTrue';
const errorHeader = 'XCTAssertFalse'

// Test stats object
var lexStats = {
  testCount: 0,
  dictionary: [],
  dictionarySize: function() {
    return this.dictionary.length;
  },
  errorCount: 0,
  lengthCounter: [0, 0, 0, 0, 0, 0],  // number of words of lengths 4-9
  startCounter: {},                   // number of words starting with pattern
  endCounter: {},                     // number of words ending with pattern
  containCounter: {}                  // number of words containing pattern
};

// Alphabet characters
var alphas = _.range(
    'A'.charCodeAt(0),
    'Z'.charCodeAt(0)+1
);
var letters = _.map(alphas, a => String.fromCharCode(a));
var vowels = "AEIOUY".split("");
var consonants = "BCDFGHJKLMNPQRSTVWXYZ".split("");

// Initialize all the various stat counters
letters.forEach( (letter) => { lexStats.startCounter[letter] = 0 });
lexStats.endCounter["S"] = 0;
lexStats.endCounter["Y"] = 0;
lexStats.endCounter["ED"] = 0;
lexStats.endCounter["ER"] = 0;
lexStats.endCounter["OR"] = 0;
lexStats.endCounter["LY"] = 0;
lexStats.endCounter["EST"] = 0;
lexStats.endCounter["ING"] = 0;
lexStats.endCounter["TION"] = 0;
lexStats.endCounter["SION"] = 0;

// Open the test directory
files = fs.readdirSync(testdir);

// Loop through files in test directory
files.forEach( (file, index) => {

 	let testpath = path.join(testdir, file);

 	// Verify file not directory
 	stats = fs.statSync(testpath);

	if (stats.isFile()) {

      // Get the file extension to make sure it's a Swift file
      // ASSUME format is name.extension
        let filetokens = file.split('.');

        if (filetokens.length > 1 && filetokens[1] === "swift") {
            console.log(`confirmed Swift file: ${filetokens[0]}`);

			 	// Open the file for reading
			 	let fd = fs.openSync(testpath, "r");

			 	// Read contents into string buffer and break into individual lines
			 	let fileBuffer = fs.readFileSync(fd, 'utf8');
			 	let fileLines = fileBuffer.split('\n');

			 	// Iterate through each line in the buffer
			 	fileLines.forEach( (line, index) => {

          // Testcase header
          if (line.search(testHeader) >= 0) {
            lexStats.testCount += 1;

          // Error case header
          } else if (line.search(errorHeader) >= 0) {
            lexStats.errorCount += 1;

			 		// Word verification header
          } else if (line.search(wordHeader) >= 0) {

            // Actual word is inside the double quotes
            let lineTokens = line.split('"');

            // The middle token is the word to add to the dictionary
            let newWord = lineTokens[1];

            // Add the new word if not already present
            if (!lexStats.dictionary.includes(newWord)) {
              lexStats.dictionary.push(newWord);

              // Increment the appropriate word length counter
              let wordLength = newWord.length
              if (wordLength >= 4 && wordLength <= 9) {
                lexStats.lengthCounter[wordLength - 4] += 1;
              } else {
                console.log(`Word ${newWord} out of valid length range`);
              }

              // Zero in on the various start and ending patterns
              let startChar = newWord.substring(0, 1);
              let lastChar = newWord.substring(wordLength - 1, wordLength);
              let nextToLast = newWord.substring(wordLength - 2, wordLength - 1);
              let lastTwo = newWord.substring(wordLength - 2, wordLength);
              let lastThree = newWord.substring(wordLength - 3, wordLength);
              let lastFour = newWord.substring(wordLength - 4, wordLength);

              // Increment the appropiate section counter
              lexStats.startCounter[startChar] += 1;

              // Increment the various pattern counters
              // State nouns
              if (lastFour === "TION" || lastFour === "SION") {
                lexStats.endCounter[lastFour] += 1;

              // Gerunds and superlatives
              } else if (lastThree === "ING" || lastThree == "EST") {
                lexStats.endCounter[lastThree] += 1;

              // Adverbs, past tense verbs, comparatives/actor nouns
              } else if (lastTwo === "LY" || lastTwo === "ED" ||
                         lastTwo === "ER" || lastTwo === "OR") {
                lexStats.endCounter[lastTwo] += 1;

              // Plurals and other Y enders
              } else if ((lastChar === "S" && nextToLast !== "S") || lastChar === "Y") {
                lexStats.endCounter[lastChar] += 1;
              }

            } else {
              console.log(`Duplicate item ${lineTokens[1]} found`)
            }
			 		}
			 	});
			} // endif

		 } // endif

 }); // end forEach

// Sort the dictionary
lexStats.dictionary.sort();

// console.dir(lexStats);

// Fire up the HTTP server
const server = http.createServer( (request, response) => {
  var date = new Date();
  var dateString = `${date.getDate()}-${date.getMonth()+1}-${date.getFullYear()}`;

  // Page top header
  var html = '<h1>Lexografik Dictionary</h1>';

  // Overall counts
  let wordCount = lexStats.dictionarySize();
  let wordPct = Number(wordCount/lexStats.testCount).toFixed(1);
  html += `<p>${lexStats.testCount} test cases, `;
  html += `<b>${wordCount}</b> total words (${wordPct} words per test case), `;
  html += `${lexStats.errorCount} error checks`;

  // Word counts
  html += `<h2>Length totals</h2><p>`;
  for (var x = 0; x < 6; x++) {
    html += `<i>${lexStats.lengthCounter[x]}</i> ${x+4}-letter words<br>`;
  }

  // Pattern counts
  html += `<h2>Pattern totals</h2><p>`;
  let pluralCount = lexStats.endCounter["S"];
  let pluralPct = Number(pluralCount/wordCount*100).toFixed(1);
  let pastCount = lexStats.endCounter["ED"];
  let gerundCount = lexStats.endCounter["ING"];
  let adverbCount = lexStats.endCounter["LY"];
  let actorCount = lexStats.endCounter["ER"] + lexStats.endCounter["OR"];
  let stateCount = lexStats.endCounter["TION"] + lexStats.endCounter["SION"];
  let superCount = lexStats.endCounter["EST"];
  let finalYCount = lexStats.endCounter["Y"];

  html += `${pluralCount} plurals (${pluralPct}%)<br>`;
  html += `${pastCount} past tense verbs<br>`;
  html += `${gerundCount} gerunds<br>`;
  html += `${adverbCount} adverbs<br>`;
  html += `${finalYCount} words ending in Y<br>`;
  html += `${actorCount} actor/comparative<br>`;
  html += `${superCount} superlatives<br>`;
  html += `${stateCount} state nouns<br>`;

  // Initialize dictionary iterators
  var wordIndex = 0;
  var currentWord = lexStats.dictionary[wordIndex];
  html += `<h2>Dictionary</h2>`;

  // Subheadings for each letter with respective word count
  _.each(letters, (letter) => {
      html += `<h3>${letter} - ${lexStats.startCounter[letter]} words</h3><p>`;

      // Add words in dictionary that start with the current letter
      while (currentWord.substring(0, 1) === letter) {
        html += `${currentWord}      `;
        wordIndex += 1;
        if (wordIndex < wordCount) {
          currentWord = lexStats.dictionary[wordIndex]
        }
        else {
          break;
        }
      }
  });

  response.writeHead(200, {'Content-Type': 'text/html'});
  response.end(html);

}).listen(3000);
