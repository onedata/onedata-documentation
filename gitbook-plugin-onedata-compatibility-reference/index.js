var path = require('path');
var fs = require('fs-extra');
var Precompiler = require('handlebars/dist/cjs/precompiler')

var compatibilityReferenceDir = 'doc/compatibility_reference/';

module.exports = {
  hooks: {
    finish: function () {
      var book = this;
      
      var templateSource = book.resolve(compatibilityReferenceDir, 'tables.handlebars');
      var templateOutput = path.resolve(book.options.output, compatibilityReferenceDir, 'tables.js');
      
      book.log.info.ln('precompiling handlebars compatibility tables: ' + templateSource + ' -> ' + templateOutput);
      var handlebarsOptions = {
        files: [ templateSource ],
        output: templateOutput,
        extension: 'handlebars',
        namespace: 'Handlebars.templates',
      };
      
      fs.mkdirpSync(path.resolve(book.options.output, compatibilityReferenceDir));
      
      return new Promise(function (resolve, reject) {
        try {
          Precompiler.loadTemplates(handlebarsOptions, function(err, opts) {
            if (err) {
              throw err;
            }
            
            Precompiler.cli(opts);
            
            book.log.info.ln('copying compatibility tables assets...');
            fs.copySync(
              path.resolve(__dirname, 'node_modules/handlebars/dist/handlebars.runtime.min.js'),
              path.resolve(book.options.output, compatibilityReferenceDir, 'handlebars.runtime.min.js')
            );
            
            resolve();
          });
        } catch (error) {
          reject(error);
        }
      });
    }
  }
};
