/* global Handlebars */

function compareVersionsDesc(a, b) {
  return window.compareVersions(b, a);
}

function uniqueArray(arrArg) {
  return arrArg.filter(function findDuplicate(elem, pos, arr) {
    return arr.indexOf(elem) === pos;
  });
}

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
  var allSecondaryVersions = [];
  var rows = [];
  var allPrimaryVersions = Object.keys(compatData);
  allPrimaryVersions.sort(compareVersionsDesc);

  allPrimaryVersions.forEach(function collectSecondaryVersions(secondaryVersion) {
    var secondaryVersions = compatData[secondaryVersion];
    Array.prototype.push.apply(allSecondaryVersions, secondaryVersions);
  });

  allSecondaryVersions = uniqueArray(allSecondaryVersions);
  allSecondaryVersions.sort(compareVersionsDesc);

  allPrimaryVersions.forEach(function generateRow(primaryVersion) {
    compatData[primaryVersion].sort(compareVersionsDesc);
    var compatibleSecondaryVersions = compatData[primaryVersion];
    rows.push({
      version: primaryVersion,
      cells: allSecondaryVersions.map(function isCompatible(secondaryVersion) {
        return compatibleSecondaryVersions.indexOf(secondaryVersion) !== -1;
      })
    });
  });
  return {
    columns: allSecondaryVersions,
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
