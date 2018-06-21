// GLOBAL VARIABLES

// Alphabet characters
const letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split("");
const vowels = "AEIOUY".split("");
const consonants = "BCDFGHJKLMNPQRSTVWXYZ".split("");

// State vars
var currentLetterView = "A";
var tabLetterView = "A";
var lexStats;

function simulateClick(target) {
  var event = new MouseEvent('click', {
    view: window,
    bubbles: true,
    cancelable: true
  });
  const targetElement = document.getElementById(target);
  targetElement.dispatchEvent(event);
}

function showDict(evt, letter) {
    // Declare all variables
    var i, tabcontent, tablinks;

    currentLetterView = letter;

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
    const currentTab = document.getElementById(letter);
    currentTab.style.display = "block";
    evt.currentTarget.className += " active";
}

function buildDictionaryDisplay() {
  const rowSize = 12;     // Number of words per row
  let wordCount = lexStats.dictionary.length;
  var wordIndex = 0;
  var currentWord = lexStats.dictionary[wordIndex];
  var html = '';

  // View filter variables
  let displayType = document.querySelector('input[name="display_type"]:checked').value;
  //console.log('Display type is', displayType);

  var lengthView = 0;   // Setting of 0 means view all word lengths
  if (word_length.value !== "any") {
    lengthView = Number(word_length.value);
  }

  let filterView = filter_type.value;
  let filterString = filter.value.toUpperCase();
  let filterLength = filterString.length;

//  console.log('word length setting is', word_length.value);
  // console.log("Filter string:", filterString);
  // console.log("Filter length:", filterLength);

  let tabContainer = document.getElementById("tabs");
  if (displayType === "full") {
    tabContainer.style.display = 'none';
  } else {
    tabContainer.style.display = 'block';
  }

  letters.forEach(letter => {
    // Get the individual <div> element for each letter
    const currentTab = document.getElementById(letter);
    var rowIndex = 0;
    var displayCount = 0;

    // If displaying indvidual tabs, reset the HTML string
    if (displayType === "tabs") {
      html = '';

    // Otherwise, tack on heading for current letter
    } else {
      html += `<h3>${letter}</h3>`;
    }
    html += `<table>`;

    // Add words in dictionary that start with the current letter
    while (currentWord.substring(0, 1) === letter) {

      // These need to be reset for each iteration
      let currentLength = currentWord.length;
      var containsPlural = false;
      var skipWord = false;

      // console.log(`Starting length check for ${currentWord}, skipWord currently`, skipWord);

      // Filter out plurals only for default view settings
      if (lengthView === 0) {

        if (currentWord.substring(currentLength - 1, currentLength) === "S" &&
            currentWord.substring(currentLength - 2, currentLength - 1) !== "S") {
          let currentRoot = currentWord.substring(0, currentLength - 1);
          if (lexStats.dictionary.indexOf(currentRoot) >= 0) {
            skipWord = true;
          }

        } else {
          let currentPlural = currentWord + "S";
          if (lexStats.dictionary.indexOf(currentPlural) >= 0) {
            containsPlural = true;
          }
        }

      // Honor word length option
      } else {
        if (compare.value === "EQ" && currentLength !== lengthView) {
          skipWord = true;
        } else if (compare.value === "LT" && currentLength > lengthView) {
          skipWord = true;
        } else if (compare.value === "GT" && currentLength < lengthView) {
          skipWord = true;
        }
      }

      // console.log(`Finished length check for ${currentWord}, skipWord currently`, skipWord);

      // Now process the filter
      if (!skipWord && filterString !== "") {

        if (filterView === "word_start") {
          let filterSub = currentWord.substring(0, filterLength);
          if (filterSub !== filterString) {
            skipWord = true
          } else {
            skipWord = false;
          }

        } else if (filterView === "word_end") {
          let filterSub = currentWord.substring(currentLength - filterLength,
                                                currentLength);
          if (filterSub !== filterString) {
            skipWord = true;
          } else {
            skipWord = false;
          }

        } else if (filterView === "word_contains") {
          if (currentWord.indexOf(filterString) === -1) {
            skipWord = true;
          } else {
            skipWord = false;
          }

        } else if (filterView === "initial_vowel") {

        } else if (filterView === "syllable_end") {

        }

      }

      if (!skipWord) {
        // start a new row at 0
        if (rowIndex === 0) {
          html += `<tr>`
        }

        // set the display properties for the individual word
        //console.log(`Adding table cell for ${currentWord}`)
        if (containsPlural) {
          html += `<td>${currentWord}(S)</td>`;
        } else {
          html += `<td>${currentWord}</td>`;
        }
        displayCount += 1;

        // close out the row when rowSize is reached and reset the rowIndex
        rowIndex += 1;
        if (rowIndex === rowSize) {
          html += `</tr>`;
          rowIndex = 0;
        }
      } else {
        // console.log("Skipped word", currentWord);
      }

      // advance to the next word
      wordIndex += 1;
      if (wordIndex < wordCount) {
        currentWord = lexStats.dictionary[wordIndex]
      } else {
        break;
      }
    } // while

    html += `</table>`;
    html += `<p>${displayCount} unique words</p>`;

    if (displayType === "tabs") {
      currentTab.innerHTML = html;
    }
  });

  if (displayType === "full") {
    document.getElementById("A").innerHTML = html;
  }
}

function rebuildDisplay() {
  buildDictionaryDisplay();

  let displayType = document.querySelector('input[name="display_type"]:checked').value;

  // Full display always uses the first tab
  if (displayType === "full") {

    // Remember the current tab in case display switches back
    if (currentLetterView !== "A") {
      tabLetterView = currentLetterView;
    }
    currentLetterView = "A";

  // If a "stars with" filter is set, use the first character for the active tab
  } else if (filter_type.value === "word_start" && filter.value !== "") {
    currentLetterView = filter.value.toUpperCase().substring(0, 1);

  // Otherwise restore the last tab
  } else {
    currentLetterView = tabLetterView;
  }



  // Simulate mouse click on the current/new tab
  simulateClick(`${currentLetterView}_tab`);
  }

function checkStatus(response) {
  if (response.ok) {
    return Promise.resolve(response);
  } else {
    return Promise.reject(console.log('Promise rejected with response ', response));
  }
}

function fetchData(url) {
  return fetch(url)
          .then(checkStatus)
          .then(res => res.json())
          .catch(error => console.log('Error encountered:', error))
}

// Main execution
const statsURL = 'http://localhost/~jaywright/dictionary.json'
fetchData(statsURL)
  .then(data => {
    lexStats = data;
    rebuildDisplay();
  });
