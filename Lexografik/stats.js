// GLOBAL VARIABLES

// Data structure returned from server
var lexStats;

// State vars
var selectedView = "A";
var selectedTab = "A";
var firstValidTab = "";

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
// If letter is set to 'full', then show the full display tabContainer
// If letter is set to 'stat', then show the stats container
// If letter is set to ' ', then show the last selected tab
function showDict(evt, letter) {
    var i, tabcontent, tablinks;
    let tabContainer = document.getElementById("tabs");

    // Hide EVERY view: cancel display for all elements with class="tabcontent"
    tabcontent = document.getElementsByClassName("tabcontent");
    for (i = 0; i < tabcontent.length; i++) {
        tabcontent[i].style.display = "none";
    }

    // Deselect EVERY tab: remove class "active" for all class="tablinks"
    tablinks = document.getElementsByClassName("tablinks");
    for (i = 0; i < tablinks.length; i++) {
        tablinks[i].className = tablinks[i].className.replace(" active", "");
    }

    // If viewing stats, hide all the filter options and the summary count
    if (letter === 'stat') {
      document.getElementById("length_group").style.display = "none";
      document.getElementById("filter_group").style.display = "none";
      document.getElementById("settings_group").style.display = "none";
      document.getElementById("summary").style.display = "none";
    } else {
      document.getElementById("length_group").style.display = "inline";
      document.getElementById("filter_group").style.display = "inline";
      document.getElementById("settings_group").style.display = "inline";
      document.getElementById("summary").style.display = "block";
    }

    // If viewing tabs, make sure the tab bar is visible
    if (letter !== 'full' && letter != 'stat') {
      tabContainer.style.display = "block";

      // If letter is a blank character, then reset to the last selected tab
      if (letter === ' ') {
        selectedView = selectedTab;
        document.getElementById(`${selectedTab}_tab`).className += " active";

      // Otherwise make the selected tab active
      } else {
        evt.currentTarget.className += " active";
        selectedTab = letter;
        selectedView = letter;
      }

    // Hide the tab buttons if viewing full display or stats
    } else {
      tabContainer.style.display = "none";
      selectedView = letter
    }

    // Now display the currently selected view
    document.getElementById(selectedView).style.display = "block";
}

function buildStatRow(statType, keyIndex, caption) {
  const wordCount = lexStats.dictionary.length;
  var total1 = 0, total2 = 0;
  var percent;

  // Number of test cases
  if (statType === 'test') {
    total1 = lexStats.testCount;

  // Number of words and average words per test case
  } else if (statType === 'word') {
    total1 = wordCount;
    percent = Number(wordCount/lexStats.testCount).toFixed(2);

  // Number of error checks
  } else if (statType === 'error') {
    total1 = lexStats.errorCount;

  // Word length stats
  } else if (statType === 'length') {
    total1 = lexStats.lengthCounter[parseInt(keyIndex)]
    percent = Number(total1/wordCount*100).toFixed(2);

  // Starting letter stats
  } else if (statType === 'letter') {
    total1 = lexStats.startCounter[keyIndex];
    percent = Number(total1/wordCount*100).toFixed(2);

  // Ending pattern stats
  } else if (statType === 'pattern') {
    var keys = keyIndex.split('+');
    total1 = lexStats.endCounter[keys[0]];
    if (keys.length > 1) {
      total2 = lexStats.endCounter[keys[1]];
    }
  percent = Number((total1 + total2)/wordCount*100).toFixed(2);
  }

  // Start a new HTML row
  var rowHTML = '<span class="statrow">';

  // Caption is first column
  rowHTML += `<span class="statcap">${caption}:</span>`;

  // Total is second column
  rowHTML += `<span class="stattot">${total1 + total2}</span>`;

  // Third column: For word totals, percent is actually an average
  if (statType === 'word') {
    rowHTML += `<span class="statpct">(${percent} words per case)</span>`;

  // Percentage is normal third column
  } else if (statType !== 'test' && statType != 'error') {
    rowHTML += `<span class="statpct">(${percent}%)</span>`;
  }

  rowHTML += `</span>`;
  return rowHTML
}

// Constructs all the dynamic html for displaying the dictionary
function buildDictionaryDisplay() {
  const rowSize = 11;     // Number of words per row
  let wordCount = lexStats.dictionary.length;
  var wordIndex = 0;
  var currentWord = lexStats.dictionary[wordIndex];
  var fullHTML = "";
  var aggCount = 0;

  // Get the display settings
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

  // Reset the first open tab value here since the filter may be changing
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
    var sectionHTML = `<h3>${letter}</h3>`;
    var headerHTML = '';

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
      if (!pluralCheck.checked) {

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
      }

      // Honor word length option
      if (lengthView !== 0) {
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
      if (((!skipLength && !skipFilter) || highCheck.checked) && !skipPlural) {

        // Start a new row when the index has been reset to 0
        if (rowIndex === 0) {
          tableHTML += `<tr>`
        }

        // Highlight filtered words when that option is active
        if (!skipLength && !skipFilter && highCheck.checked) {
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
      } else {
        currentTab.disabled = false;
      }

    // Fill in the word totals for the header
    } else {
      var displayPct;
      var sectionPct = Number(sectionCount/wordCount*100).toFixed(2);

      // No filtering
      if (filter.value === "" && lengthView === 0) {
        aggCount += displayCount
        displayPct = Number(displayCount/sectionCount*100).toFixed(2);
        if (!pluralCheck.checked) {
          headerHTML += `${displayCount} unique (${displayPct}%) out of `;
        }

      // Highlighting
      } else if (highCheck.checked) {
        aggCount += highCount
        displayPct = Number(highCount/sectionCount*100).toFixed(2);
        headerHTML += `${highCount} selected (${displayPct}%) out of `;

      // Normal filtering
      } else {
        aggCount += displayCount
        displayPct = Number(displayCount/sectionCount*100).toFixed(2);
        headerHTML += `${displayCount} selected (${displayPct}%) out of `;
      }

      // Add the overall total
      headerHTML += `${sectionCount} (${sectionPct}%)</p>`;

      // Keep track of the first tab to have a non-empty display
      if (firstValidTab === "") {
        firstValidTab = letter;
      }

      // Enable the current tab and highlight it if that option is enabled
      currentTab.disabled = false;
      if (highCheck.checked && highCount > 0) {
        if (currentTab.className.indexOf(" highlight") === -1) {
          currentTab.className += " highlight";
        }
      } else {
        currentTab.className = currentTab.className.replace(" highlight", "");
      }
    }

    // HTML for current tab is now complete
    currentView.innerHTML = headerHTML + tableHTML;

    // Skip letters in full display with no words
    if (displayCount !== 0) {
      fullHTML += sectionHTML + headerHTML + tableHTML;
    }
  });  // forEach  (Letter iteration)

  // Display the date/time record from the query
  let dateSpan = document.getElementById('date');
  dateSpan.innerHTML = `${formatDate(lexStats.dateString)}<br>`;

  // Display the word count summary
  let sumSpan = document.getElementById('summary');
  var sumHTML;
  var sumPct;

  if (filter.value === "" && lengthView === 0) {
    if (!pluralCheck.checked) {
      sumPct = Number(aggCount/wordCount*100).toFixed(2);
      sumHTML = `${aggCount} unique (${sumPct}%) out of ${wordCount} total`;
    } else {
      sumHTML = `${wordCount} total`;
    }

  } else {
    sumPct = Number(aggCount/wordCount*100).toFixed(2);
    sumHTML = `${aggCount} selected out of ${wordCount} total (${sumPct}%)`;
  }
  sumSpan.innerHTML = sumHTML;

  // HTML for full display is complete
  document.getElementById("full").innerHTML = fullHTML;

  // Now build the stats display view
  var statHTML = '';

  // Overall counts
  statHTML += `<h2 class="statheader">Overall</h2>`;
  statHTML += buildStatRow('test', '', 'Test cases');
  statHTML += buildStatRow('word', '', 'Words');
  statHTML += buildStatRow('error', '', 'Error checks');
  // statHTML += `<span class="statrow"><span class="statcap">Test cases:`;
  // statHTML += `<span class="stattot">${lexStats.testCount}</span></span>`;
  // statHTML += `<span class="statrow"><span class="statcap">Test cases:`;
  // statHTML += `<span class="stattot">${lexStats.testCount}</span></span>`;
  //
  // let wordPct = Number(wordCount/lexStats.testCount).toFixed(2);
  //
  // statHTML += `<b>${wordCount}</b> total words (${wordPct} words per test case), `;
  // statHTML += `${lexStats.errorCount}</span>`;

  // Word counts
  statHTML += `<h2 class="statheader">Length totals</h2>`;
  for (i = 0; i < 6; i++) {
    statHTML += buildStatRow('length', `${i}`, `${i+4}-letter words`);
  }

  // Letter counts
  statHTML += `<h2 class="statheader">Letter totals</h2>`;
  letters.forEach(letter => {
    statHTML += buildStatRow('letter', letter, letter);
  });

  // Pattern counts
  statHTML += `<h2 class="statheader">Pattern totals</h2>`;
  // let plural5Count = pluralCount - plural4Count;
  // let pluralPct = Number(plural5Count/wordCount*100).toFixed(2);

//  statHTML += `${plural5Count} non-unique (${pluralPct}%) / `;
//  statHTML += `${plural4Count} unique</i><br>`
  statHTML += buildStatRow('pattern', 'S', 'Plurals');
  statHTML += buildStatRow('pattern', 'S4', 'Unique plurals')
  statHTML += buildStatRow('pattern', 'ED', 'Past tense (ED)');
  statHTML += buildStatRow('pattern', 'ING', 'Gerund (ING)');
  statHTML += buildStatRow('pattern', 'LY', 'Adverb (LY)');
  statHTML += buildStatRow('pattern', 'Y', 'Other final Y');
  statHTML += buildStatRow('pattern', 'ER+OR', 'ER/OR');
  statHTML += buildStatRow('pattern', 'EST', 'EST');
  statHTML += buildStatRow('pattern', 'SION+TION', 'SION/TION');

  document.getElementById("stat").innerHTML = statHTML;
}

function enableOption(optionID) {
//  console.log(`Enabling option ${optionID}`);
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

// Resets the display based on the current settings
function rebuildDisplay() {
  let currentDisplay = getDisplayType();

  // If filter type set to None then clear out the field and disable highlight
  if (filter_type.value === "none") {
    filter.value = "";
    filter.disabled = true;
  } else {
    filter.disabled = false;
  }

  // The highlight option is DISABLED by default; it is enabled if a word
  // length or filter value is in effect
  if (word_length.value !== "any" || filter.value !== "") {
    enableOption('high');
  } else {
    disableOption('high');
  }

  // The plural option is ENABLED by default; it is disabled if a word length
  // option is in effect or the filter type is set to match a word ending
  if (word_length.value !== "any" || filter_type.value === "end" ||
        filter_type.value === "fvowel") {
    disableOption('plural');
  } else {
    enableOption('plural');
  }

  // This check prevents an unnecessary refresh when changing the filter type
  // before entering a filter value
  if (filter.value !== "" || filter_type.value === "none") {
    buildDictionaryDisplay();

    // Displaying one of the tabs
    if (currentDisplay === "tabs") {
      let currentTab = document.getElementById(`${selectedTab}_tab`);

      // Reset the current tab if it no longer has any words in it
      if (currentTab.disabled && firstValidTab !== "") {
        selectedView = firstValidTab;
      }

      // Simulate mouse click on the current/new tab
      simulateClick(`${selectedView}_tab`);
    }

    else {
      simulateClick(`display_${currentDisplay}`)
    }
  }
}

function resetDefault() {
  selectedView = "A";
  selectedTab = "A";
  firstValidTab = "";
  word_length.value = "any";
  filter_type.value = "none";
  document.getElementById('display_tabs').checked = true
  rebuildDisplay();
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
reloadPage();
