// GLOBAL VARIABLES

// Alphabet characters
const letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split("");
//const vowels = "AEIOUY".split("");
const vowelExp = new RegExp('[AEIOUY]')
//const consonants = "BCDFGHJKLMNPQRSTVWXYZ".split("");
const consExp = new RegExp('[BCDFGHJKLMNPQRSTVWXZ]')

// State vars
var currentLetterView = "A";
var tabLetterView = "";
var firstValidTab = "";
var lexStats;

// Returns the value of the radio button setting for the display type
function getDisplayType() {
    return document.querySelector('input[name="display_type"]:checked').value;
}

// Simulates a mouse click event (mainly used for tabs)
function simulateClick(target) {
  var event = new MouseEvent('click', {
    view: window,
    bubbles: true,
    cancelable: true
  });
  const targetElement = document.getElementById(target);
  targetElement.dispatchEvent(event);
}

// Resets the display of the tab container based on the given letter
function showDict(evt, letter) {
    // Declare all variables
    var i, tabcontent, tablinks;

    // Remember the current letter in case the view display switches
    currentLetterView = letter;
    if (getDisplayType() === "tabs") {
      tabLetterView = letter;
    }

    // Get all elements with class="tabcontent" and hide them
    tabcontent = document.getElementsByClassName("tabcontent");
    for (i = 0; i < tabcontent.length; i++) {
        tabcontent[i].style.display = "none";
    }

    // Get all elements with class="tablinks" and remove the class "active"
    tablinks = document.getElementsByClassName("tablinks");
    for (i = 0; i < tablinks.length; i++) {
        tablinks[i].className = tablinks[i].className.replace(" active", "");
    }

    // Show the current tab, and add an "active" class to the button that opened the tab
    const currentView  = document.getElementById(letter);
    currentView.style.display = "block";
    evt.currentTarget.className += " active";
}

// Display the stats page and hide all the other letter views
function displayStats() {
    var i, tabcontent, tablinks;

    // Hide the tabs
    document.getElementById("tabs").style.display = "none";

    // Access the stat container
    let statView = document.getElementById('stats');
    var statHTML = "";

    // Overall counts
    let wordCount = lexStats.dictionary.length;
    let wordPct = Number(wordCount/lexStats.testCount).toFixed(1);
    statHTML += `<p>${lexStats.testCount} test cases, `;
    statHTML += `<b>${wordCount}</b> total words (${wordPct} words per test case), `;
    statHTML += `${lexStats.errorCount} error checks`;

    // Word counts
    statHTML += `<h2>Length totals</h2><p>`;
    for (i = 0; i < 6; i++) {
      statHTML += `<i>${lexStats.lengthCounter[i]}</i> ${i+4}-letter words<br>`;
    }

    // Pattern counts
    statHTML += `<h2>Pattern totals</h2><p>`;
    let pluralCount = lexStats.endCounter["S"];
    let plural4Count = lexStats.endCounter["S4"];
    let plural5Count = pluralCount - plural4Count;
    let pluralPct = Number(plural5Count/wordCount*100).toFixed(1);
    let pastCount = lexStats.endCounter["ED"];
    let gerundCount = lexStats.endCounter["ING"];
    let adverbCount = lexStats.endCounter["LY"];
    let actorCount = lexStats.endCounter["ER"] + lexStats.endCounter["OR"];
    let stateCount = lexStats.endCounter["TION"] + lexStats.endCounter["SION"];
    let superCount = lexStats.endCounter["EST"];
    let finalYCount = lexStats.endCounter["Y"];

    statHTML += `${pluralCount} plurals: `
    statHTML += `${plural5Count} non-unique (${pluralPct}%) / `;
    statHTML += `${plural4Count} unique<br>`
    statHTML += `${pastCount} past tense verbs<br>`;
    statHTML += `${gerundCount} gerunds<br>`;
    statHTML += `${adverbCount} adverbs<br>`;
    statHTML += `${finalYCount} words ending in Y<br>`;
    statHTML += `${actorCount} actor/comparative<br>`;
    statHTML += `${superCount} superlatives<br>`;
    statHTML += `${stateCount} state nouns<br>`;

    statView.innerHTML = statHTML;

    // Get all elements with class="tabcontent" and hide them
    tabcontent = document.getElementsByClassName("tabcontent");
    for (i = 0; i < tabcontent.length; i++) {
        tabcontent[i].style.display = "none";
    }

    // Get all elements with class="tablinks" and remove the class "active"
    tablinks = document.getElementsByClassName("tablinks");
    for (i = 0; i < tablinks.length; i++) {
        tablinks[i].className = tablinks[i].className.replace(" active", "");
    }

    // Show the stats tab
    statView.style.display = "block";
}

// Returns the initial combination of vowels in the word or null
// if only consonants are present
function initialVowel(alphaStr) {

  // Drop the initial Y if present (since Y's are treated as vowels)
  if (alphaStr[0] === "Y") {
    alphaStr = alphaStr.substring(1, alphaStr.length);
  }

  let vowelPieces = alphaStr.split(consExp);
  if (vowelPieces.length === 0) {
    return "";
  }

  // skip any null pieces
  for (i = 0; vowelPieces[i] === "" && i < vowelPieces.length - 1; i += 1);
  return vowelPieces[i];
}

// Returns any combination of vowels at the end of the word or null
// if the word ends in a consonant
function vowelEnder(alphaStr) {
  let vowelPieces = alphaStr.split(consExp);
  if (vowelPieces.length === 0) {
    console.log("No vowels in", alphaStr);
    return "";
  }

  return vowelPieces[vowelPieces.length - 1];
}

// Returns the initial consonant stop following the first vowel or null
// if the word is all vowels or has no consonants beyond the initial ones
function initialStop(alphaStr) {
  let consPieces = alphaStr.split(vowelExp);

  if (consPieces.length === 0) {
    console.log("No consonants in", alphaStr);
    return "";
  }

  // Words that start with vowels
  if (consPieces[0] === "") {
    if (consPieces.length > 1) {
      return consPieces[1];
    } else {
      return "";
    }

  // Single syllable word that ends in a vowel
  } else if (consPieces.length === 1) {
    return "";

  // Words with consonant stops
  } else {
    for (i = 1; consPieces[i] === "" && i < consPieces.length - 1; i += 1);
    return consPieces[i];
  }
}

// Constructs all the dynamic html for displaying the dictionary
function buildDictionaryDisplay() {
  const rowSize = 11;     // Number of words per row
  let wordCount = lexStats.dictionary.length;
  var wordIndex = 0;
  var currentWord = lexStats.dictionary[wordIndex];
  var fullHTML = '';
  var aggCount = 0;

  // View browser settings
  let displayType = getDisplayType();
  var lengthView = 0;     // Setting of 0 means view any & all word lengths
  if (word_length.value !== "any") {
    lengthView = Number(word_length.value);
  }
  let filterView = filter_type.value;
  let filterString = filter.value.toUpperCase();
  let filterLength = filterString.length;
  let highCheck = document.getElementById("highcheck");
  let pluralCheck = document.getElementById("pluralcheck");
  let tabContainer = document.getElementById("tabs");
  if (displayType === "full") {
    tabContainer.style.display = 'none';
  } else {
    tabContainer.style.display = 'block';
  }

  let infoSpan = document.getElementById('infospan');
  var infoHTML = '<p class="info">';

  firstValidTab = "";

  // Iterating over the entire alphabet
  letters.forEach(letter => {

    // Get the individual <div> element for each letter
    const currentView = document.getElementById(letter);
    const currentTab = document.getElementById(`${letter}_tab`);

    let sectionCount = lexStats.startCounter[letter];
    var highCount = 0;
    var rowIndex = 0;
    var displayCount = 0;
    var tableHTML = '<table>';
    var headerHTML = '';

    // Otherwise, tack on heading for current letter
    if (displayType === "full") {
      headerHTML += `<h3>${letter}</h3>`;
    }

    // Add words to the table that start with the current letter
    while (currentWord.substring(0, 1) === letter) {

      // These need to be reset for each word iteration
      let currentLength = currentWord.length;

      // true if the word doesn't conform to the current filter settings;
      // if so, don't display unless the highlight option is checked
      // ALSO true for all words in the default unfiltered display
      var skipFilter = false;

      // true if the word doesn't match the current length setting;
      // will never display if set to true
      var skipLength = false;

      // true if the word is a non-unique plural (i.e. the singular form is not
      // not found in the dictionary); if true then it should be skipped
      // completely in the table UNLESS the separatePlural option is checked
      var skipPlural = false;

      // true if the word also has a plural S form in the dictionary; if the
      // separatePlural option is checked then it has no bearing on the display
      // but if not, then will append an (S) where it appears in the table
      var hasPlural = false;

      // The plural check only happens for the default length setting
      if (lengthView === 0 && !pluralCheck.checked) {

        // Look for a final S (but not final SS)
        // Should refine this to handle the "ES" for words ending in SS
        if (currentWord.substring(currentLength - 1, currentLength) === "S" &&
            currentWord.substring(currentLength - 2, currentLength - 1) !== "S") {
          let currentRoot = currentWord.substring(0, currentLength - 1);
          if (lexStats.dictionary.indexOf(currentRoot) >= 0) {
            skipPlural = true;
          }

        // If any filter is set than skip the check for the plural form
        // Might be wise to refine this based on the type of filter
        } else if (filter.value === "") {
          let currentPlural = currentWord + "S";
          if (lexStats.dictionary.indexOf(currentPlural) >= 0) {
            hasPlural = true;
          }
        }

      // Honor word length option
      } else if (lengthView !== 0) {
        if (compare.value === "EQ" && currentLength !== lengthView) {
          skipLength = true;
        } else if (compare.value === "LT" && currentLength > lengthView) {
          skipLength = true;
        } else if (compare.value === "GT" && currentLength < lengthView) {
          skipLength = true;
        }
      }

      // Now process the filter (if the word hasn't already been filtered
      // from the length setting or if it's a non-unique plural)
      if (!skipLength && !skipPlural && filterString !== "") {

        if (filterView === "start") {
          let filterSub = currentWord.substring(0, filterLength);
          if (filterSub !== filterString) {
            skipFilter = true
          } else {
            skipFilter = false;
          }

        } else if (filterView === "end") {
          let filterSub =
            currentWord.substring(currentLength - filterLength, currentLength);
          if (filterSub !== filterString) {
            skipFilter = true;
          } else {
            skipFilter = false;
          }

        } else if (filterView === "contain") {
          if (currentWord.indexOf(filterString) === -1) {
            skipFilter = true;
          } else {
            skipFilter = false;
          }

        } else if (filterView === "ivowel") {
          if (initialVowel(currentWord) !== filterString) {
            skipFilter = true;
          } else {
            skipFilter = false;
          }

        } else if (filterView === "fvowel") {
          if (vowelEnder(currentWord) !== filterString) {
            skipFilter = true;
          } else {
            skipFilter = false;
          }

        } else if (filterView === "istop") {
          if (initialStop(currentWord) !== filterString) {
            skipFilter = true;
          } else {
            skipFilter = false;
          }
        }
      }

      // Add the word to the table if it hasn't been filtered OR if the
      // option is set to only highlight filtered words and not hide the rest
      // (Non-unique plurals are NEVER added unless the Separate option is active)
      if (!skipLength && (!skipFilter || highCheck.checked) && !skipPlural) {

        // Start a new row when the index has been reset to 0
        if (rowIndex === 0) {
          tableHTML += `<tr>`
        }

        // Highlight filtered words when that option is active
        if (filter.value !== "" && !skipFilter && highCheck.checked) {
          tableHTML += `<td class="highlight">${currentWord}</td>`;
          highCount += 1;

        // Word with co-existent plural S form
        } else if (hasPlural) {
          tableHTML += `<td>${currentWord}(S)</td>`;

        // Plain unfiltered word
        } else {
          tableHTML += `<td>${currentWord}</td>`;
        }

        // Bump up the display counter
        displayCount += 1;

        // Close out the row when rowSize is reached and reset the rowIndex
        rowIndex += 1;
        if (rowIndex === rowSize) {
          tableHTML += `</tr>`;
          rowIndex = 0;
        }
      }

      // advance to the next word
      wordIndex += 1;
      if (wordIndex < wordCount) {
        currentWord = lexStats.dictionary[wordIndex]
      } else {
        break;
      }
    } // while  (Dictionary word iteration)

    tableHTML += `</table>`;
    headerHTML += '<p class="headinfo">';


    // No words in this letter section
    if (displayCount === 0) {
      headerHTML += `No words`;

      // If displaying tabs, gray out the empty ones EXCEPT for the current view
      if (displayType === "tabs") {
        currentTab.disabled = true;
        if (tabLetterView === letter) {
          tabLetterView = "";
        }
      } else {
        currentTab.disabled = false;
      }

    } else {

      // Add the section totals
      headerHTML += `${sectionCount} words`;
      if (filter.value === "" && lengthView === 0) {
        if (!pluralCheck.checked) {
          headerHTML += ` (${displayCount} unique)`;
        }
      } else {
        headerHTML += ` (${displayCount} selected)`;
      }
      headerHTML += '</p>'

      // Aggregate counter for all letters
      aggCount += displayCount

      // Keep track of the first tab to have a non-empty display
      if (firstValidTab === "") {
        firstValidTab = letter;
//        console.log('Setting firstValidTab to', firstValidTab);
      }

      currentTab.disabled = false;
      if (highCheck.checked && highCount > 0) {
        if (currentTab.className.indexOf(" highlight") === -1) {
          currentTab.className += " highlight";
        }
      } else {
        currentTab.className = currentTab.className.replace(" highlight", "");
      }
    }

    if (displayType === "tabs") {
      currentView.innerHTML = headerHTML + tableHTML;

    // Skip letters in full display with no words
    } else if (displayCount !== 0) {
      fullHTML += headerHTML + tableHTML;
    }
  });  // forEach  (Letter iteration)

  // Build the info string displayed at the top right
  infoHTML += `${wordCount} words total`;
  if (filter.value === "" && lengthView === 0) {
    if (!pluralCheck.checked) {
      infoHTML += ` (${aggCount} unique)`;
    }
  } else {
    infoHTML += ` (${aggCount} selected)`;
  }
  infoHTML += `<br>${lexStats.dateString}</p>`;
  infoSpan.innerHTML = infoHTML;

  // Use the first (A) tab for the full display
  if (displayType === "full") {
    document.getElementById("A").innerHTML = fullHTML;
  }
}

function enableOption(optionID) {
//    console.log(`Enabling option ${optionID}`);
    labelElem = document.getElementById(`${optionID}label`);
    labelElem.className = labelElem.className.replace(" disable", "");
    checkElem = document.getElementById(`${optionID}check`);
    checkElem.disabled = false;
}

function disableOption(optionID) {
//  console.log(`Disabling option ${optionID}`);
  labelElem = document.getElementById(`${optionID}label`);
  if (labelElem.className.indexOf(" disable") === -1) {
    labelElem.className += " disable";
  }
  checkElem = document.getElementById(`${optionID}check`);
  checkElem.disabled = true;
}

function rebuildDisplay() {

  // Clear out the filter if the type is set to None and disable the
  // highlight option
  if (filter_type.value === "none") {
    filter.value = "";
    filter.disabled = true;
    disableOption('high');

    // Plural option is still valid unless word length setting is in place
    if (word_length.value === "any") {
      enableOption('plural');
    } else {
      disableOption('plural');
    }

  // If a filter is specified, then highlight option is always enabled and
  // the plural option is always disabled
  } else {
    filter.disabled = false;
    enableOption('high');
    disableOption('plural');
  }

  // This check prevents an unnecessary refresh when changing the filter
  // setting before entering a filter value
  if (filter.value !== "" || filter_type.value === "none") {
    buildDictionaryDisplay();

    // Full display always uses the first tab
    if (getDisplayType() === "full") {
      currentLetterView = "A";

    // Honor the current user selected tab first
    } else if (tabLetterView !== "") {
      currentLetterView = tabLetterView

    // If switching to tabs with a filter in place, go to the first non-empty one
    } else if (firstValidTab !== "") {
      currentLetterView = firstValidTab;
    }

    // Simulate mouse click on the current/new tab
    simulateClick(`${currentLetterView}_tab`);
  }
}

function checkStatus(response) {
  if (response.ok) {
    return Promise.resolve(response);
  } else {
    return Promise.reject(console.log('Promise rejected with response ', response));
  }
}

function fetchData() {
  const statsURL = 'http://localhost/~jaywright/dictionary.json'
  return fetch(statsURL)
          .then(checkStatus)
          .then(res => res.json())
          .catch(error => console.log('Error encountered:', error))
}

function reloadPage() {
  fetchData()
    .then(data => {
      lexStats = data;
      rebuildDisplay();
    });
}

// Main execution
var cn = " "
reloadPage();
