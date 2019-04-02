/* global Handlebars */

function uniqueArray(arrArg) {
  return arrArg.filter(function findDuplicate(elem, pos, arr) {
    return arr.indexOf(elem) === pos;
  });
}

// example maybe to delete
// var mockJson = {
//   'oz-op': {
//     '18.02.0-rc11': ['18.02.0-rc11'],
//     '18.02.0-rc12': ['18.02.0-rc11', '18.02.0-rc12'],
//     '18.02.0-rc13': ['18.02.0-rc11', '18.02.0-rc12', '18.02.0-rc13'],
//     '18.02.1': ['18.02.0-rc11', '18.02.0-rc12', '18.02.0-rc13', '18.02.1']
//   },
//   'op-op': {
//     '18.02.0-rc11': ['18.02.0-rc11'],
//     '18.02.0-rc12': ['18.02.0-rc11', '18.02.0-rc12'],
//     '18.02.0-rc13': ['18.02.0-rc11', '18.02.0-rc12', '18.02.0-rc13'],
//     '18.02.1': ['18.02.0-rc11', '18.02.0-rc12', '18.02.0-rc13', '18.02.1']
//   },
//   'op-oc': {
//     '18.02.0-rc11': ['18.02.0-rc11'],
//     '18.02.0-rc12': ['18.02.0-rc11', '18.02.0-rc12'],
//     '18.02.0-rc13': ['18.02.0-rc11', '18.02.0-rc12', '18.02.0-rc13'],
//     '18.02.1': ['18.02.0-rc11', '18.02.0-rc12', '18.02.0-rc13', '18.02.1']
//   }
// };

function fetchCompatibilityJson(onSuccess, onError) {
  var xhr = new XMLHttpRequest();
  xhr.open('GET', 'compatibility_reference/compatibility.json', true);
  xhr.setRequestHeader('Accept', 'application/json');
  xhr.onreadystatechange = function handleResponse() {
    if (xhr.status >= 200 && xhr.status < 300) {
      onSuccess && onSuccess(JSON.parse(xhr.responseText));
    } else {
      onError && onError(xhr.response);
    }
  };
  xhr.send();
}

function generateTableData(compatData) {
  var allOpVersions = [];
  var rows = [];
  Object.keys(compatData).forEach(function collectOpVersions(ozVersion) {
    var opVersions = compatData[ozVersion];
    Array.prototype.push.apply(allOpVersions, opVersions);
  });
  allOpVersions = uniqueArray(allOpVersions);

  Object.keys(compatData).forEach(function generateRow(ozVersion) {
    var compatibleOpVersions = compatData[ozVersion];
    rows.push({
      version: ozVersion,
      cells: allOpVersions.map(function isCompatible(opVersion) {
        return compatibleOpVersions.indexOf(opVersion) !== -1;
      })
    });
  });
  return {
    columns: allOpVersions,
    rows: rows
  };
}

function generateContext(data) {
  return {
    data,
    zp: Object.assign({
      serviceInRows: 'Onezone',
      serviceInColumns: 'Oneprovider',
      tableId: 'zp'
    }, generateTableData(data['oz-op'])),
    pp: Object.assign({
      serviceInRows: 'Oneprovider',
      serviceInColumns: 'Oneprovider',
      tableId: 'pp'
    }, generateTableData(data['op-op'])),
    pc: Object.assign({
      serviceInRows: 'Oneprovider',
      serviceInColumns: 'Oneclient',
      tableId: 'pc'
    }, generateTableData(data['op-oc']))
  };
}

function renderCompatibilityTables(data) {
  var context = generateContext(data);

  var zpHtml = Handlebars.templates.tables(context.zp);
  document.getElementById('template-target-zp').innerHTML = zpHtml;

  var ppHtml = Handlebars.templates.tables(context.pp);
  document.getElementById('template-target-pp').innerHTML = ppHtml;

  var pcHtml = Handlebars.templates.tables(context.pc);
  document.getElementById('template-target-pc').innerHTML = pcHtml;
}

function renderFetchError(error) {
  document.getElementById('error').innerHTML =
    'Cannot get compatibility data: ' + error;
}

function compatibilityReferenceMain() {
  fetchCompatibilityJson(
    renderCompatibilityTables,
    renderFetchError,
  );
}

(function main() {
  compatibilityReferenceMain();
})();
