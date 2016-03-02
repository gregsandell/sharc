#!/usr/bin/env ruby
require 'fileutils'
rootJsonDir = "../json"
FileUtils.rm_rf("#{rootJsonDir}")
Dir.mkdir rootJsonDir
metafileObj = File.new("#{rootJsonDir}/metadata.json", "w")
metajson = "["
Dir['../sharc/*'].each_with_index do |_instDir, instIndex|
    instDir = File.basename(_instDir)
    if instDir == 'README' || instDir == "." || instDir == ".."
        next
    end
    if instIndex != 0
        metajson += ","
    end
    metajson += "\n\t{\n\t\t\"instname\": \"#{instDir}\",\n\t\t\"notes\": ["
    jsonInstDir = "../json/#{instDir}"
    Dir.mkdir jsonInstDir
    rootDir = "../sharc/#{instDir}"
    contentsFile = "#{rootDir}/CONTENTS"
    puts "#{instIndex} #{contentsFile}"
    File.readlines(contentsFile).each_with_index do |noteline, noteIndex|
        contentsTokens = noteline.strip.split( /\s+/ );
        note = contentsTokens[0]
        sanitizedNote = note.gsub(/#/, "s")
        fundfreq = contentsTokens[4].to_f
        notefile = "#{rootDir}/#{note}.spect"
        maxamp = contentsTokens[3].to_f
        jsonOutputFile = "#{jsonInstDir}/#{sanitizedNote}.json"
        outfileObj = File.new(jsonOutputFile, "w")
        json = "{\n\t\"inst\": \"#{instDir}\",\n\t\"note\": \"#{note}\",\n\t\"fundfreq\": #{fundfreq},\n\t\"harmonics\": ["
        if noteIndex != 0
            metajson += ","
        end
        jsonAjaxFile = jsonOutputFile.gsub(/\.\.\//, "")
        metajson += "\n\t\t\t{\n\t\t\t\t\"note\": \"#{note}\",\n\t\t\t\t\"file\": \"#{jsonAjaxFile}\"\n\t\t\t}"
        File.readlines(notefile).each_with_index do |harmonicline, index|
            harmonicTokens = harmonicline.strip.split( /\s+/ );
            db = harmonicTokens[0]
            amp = ((10 ** (db.to_f/20)) * maxamp).round(5)
            if index != 0
                json += ","
            end
            freq = ((index + 1) * fundfreq).round(5)
            json += "\n\t\t{\n\t\t\t\"num\": #{index + 1},\n\t\t\t\"freq\": #{freq},\n\t\t\t\"amp\": #{amp},\n\t\t\t\"db\": #{db},\n\t\t\t\"phase\": #{harmonicTokens[1]}\n\t\t}"
        end
        json += "\n\t]\n}"
        outfileObj.puts json
    end
    metajson += "\n\t\t]\n\t}"
end
metajson += "]"
metafileObj.puts metajson
# var sync = require('synchronize')
# var fs = require('fs');
# 
# sync(fs, 'readdir', 'createReadStream');
# function getContentsFileList() {
#     var result = [];
#     fs.readdir( "../sharc", function (err, files) { 
#         if (!err) 
#             for (file in files) {
#                 if (files[file] == "README") {
#                     continue;
#                 }
#                 var contentsPath = "../sharc/" + files[file] + "/CONTENTS";
#                 console.log(contentsPath);
#                 var contentsInput = fs.createReadStream(contentsPath);
#                 readLines(contentsInput, function(contentsData) {
#                     var contentsTokens = contentsData.match(/\S+/g);
#                     var pitch = contentsTokens[0];
#                     var notepath = "../sharc/" + files[file] + "/" + pitch + ".spect";
#                     console.log(notepath);
#                     var noteInput = fs.createReadStream(notepath);
#                     readLines(noteInput, function(noteData) {
#                         console.log(noteData);
#                     });
#                 });
#             }
#             
#         else
#             throw err; 
#     });
#     return result;
# }
# function readLines(input, func) {
#   var remaining = '';
# 
#   input.on('data', function(data) {
#     remaining += data;
#     var index = remaining.indexOf('\n');
#     while (index > -1) {
#       var line = remaining.substring(0, index);
#       remaining = remaining.substring(index + 1);
#       func(line);
#       index = remaining.indexOf('\n');
#     }
#   });
# 
#   input.on('end', function() {
#     if (remaining.length > 0) {
#       func(remaining);
#     }
#   });
# }
# getContentsFileList();
