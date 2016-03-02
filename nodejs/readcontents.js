var sync = require('synchronize')
var fs = require('fs');

sync(fs, 'readdir', 'createReadStream');
function getContentsFileList() {
    var result = [];
    fs.readdir( "../sharc", function (err, files) { 
        if (!err) 
            for (file in files) {
                if (files[file] == "README") {
                    continue;
                }
                var contentsPath = "../sharc/" + files[file] + "/CONTENTS";
                console.log(contentsPath);
                var contentsInput = fs.createReadStream(contentsPath);
                readLines(contentsInput, function(contentsData) {
                    var contentsTokens = contentsData.match(/\S+/g);
                    var pitch = contentsTokens[0];
                    var notepath = "../sharc/" + files[file] + "/" + pitch + ".spect";
                    console.log(notepath);
                    var noteInput = fs.createReadStream(notepath);
                    readLines(noteInput, function(noteData) {
                        console.log(noteData);
                    });
                });
            }
            
        else
            throw err; 
    });
    return result;
}
function readLines(input, func) {
  var remaining = '';

  input.on('data', function(data) {
    remaining += data;
    var index = remaining.indexOf('\n');
    while (index > -1) {
      var line = remaining.substring(0, index);
      remaining = remaining.substring(index + 1);
      func(line);
      index = remaining.indexOf('\n');
    }
  });

  input.on('end', function() {
    if (remaining.length > 0) {
      func(remaining);
    }
  });
}
getContentsFileList();
