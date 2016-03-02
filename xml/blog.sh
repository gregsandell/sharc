#! /bin/bash
# Instruments & notes
# xmlstarlet sel -t -m /tree/instrument/note -v ../@name -o "|" -v @pitch -n sharc.xml

# Add harmonic number and amplitude
# xmlstarlet sel -t -m /tree/instrument/note/a -v ../../@name -o "|" -v ../@pitch -o "|" -v @n -o "|" -v . -n sharc.xml

# Add fundamental frequency of pitch
# xmlstarlet sel -t -m /tree/instrument/note/a -v ../../@name -o "|" -v ../@pitch -o "|" -v ../@fundHz -o "|" -v @n -o "|" -v . -n sharc.xml


# Instead of fundHz, add frequency of each harmonic
# xmlstarlet sel -t -m /tree/instrument/note/a -v ../../@name -o "|" -v ../@pitch -o "|" -v @n -o "|" -v "../@fundHz * @n" -o "|" -v . -n sharc.xml

# add phase
# xmlstarlet sel -t -m /tree/instrument/note/a -v ../../@name -o "|" -v ../@pitch -o "|" -v @n -o "|" -v "../@fundHz * @n" -o "|" -v . -o "|" -v @p -n sharc.xml

# add column names
# xmlstarlet sel -t -o "Instrument|Pitch|Harmonic|Frequency|Amplitude|Phase" -n -m /tree/instrument/note/a -v ../../@name -o "|" -v ../@pitch -o "|" -v @n -o "|" -v "../@fundHz * @n" -o "|" -v . -o "|" -v @p -n sharc.xml

# Transform to json 
# xslt file comes from http://code.google.com/p/xml2json-xslt/downloads/list
# But it doesn't support attributes
# xmlstarlet tr xml2json.xslt alto_trombone.xml

xmlstarlet sel -t \
-m "/tree" -o "{" -v "name(.)" -o ":" \
-m @numInstruments -v "name(.)" -o ":" -v . -o ",instruments:[" -n \
-m "../instrument"  -o "{" \
-m @cd -v "name(.)" -o ":" -v "." -o "," \
-m ../@id -v "name(.)" -o ":" -v "." -o ","  \
-m ../@name -v "name(.)" -o ":&quot;" -v "." -o "&quot;,"  \
-m ../@numNotes -v "name(.)" -o ":" -v "." -o ","  \
-m ../@source -v "name(.)" -o ":" -v "." -o "," \
-m ../@track -v "name(.)" -o ":" -v "." -o ",notes:[" -n \
-m ../note  -o "{" \
-m @fundHz -v "name(.)" -o ":" -v "." -o "," \
-m ../@keyNum -v "name(.)" -o ":" -v "." -o "," \
-m ../@numHarms -v "name(.)" -o ":" -v "." -o "," \
-m ../@pitch -v "name(.)" -o ":" -v "." -o "," \
-m ../@seq -v "name(.)" -o ":" -v "." -o "," -n -o "harmonics: ["  -n \
-m ../a  -o "{" -v "name(.)" -o ":" -v . -o "," \
-m @n -v "name(.)" -o ":" -v "." -o "," \
-m ../@p -v "name(.)" -o ":" -v "." -o "}," \
-n sharc.xml

# tree
# tree/@numInstruments
# tree/instrument
# tree/instrument/@cd
# tree/instrument/@id
# tree/instrument/@name
# tree/instrument/@numNotes
# tree/instrument/@source
# tree/instrument/@track
# tree/instrument/note
# tree/instrument/note/@fundHz
# tree/instrument/note/@keyNum
# tree/instrument/note/@numHarms
# tree/instrument/note/@pitch
# tree/instrument/note/@seq
# tree/instrument/note/a
# tree/instrument/note/a/@n
# tree/instrument/note/a/@p
# tree/instrument/note/ranges
# tree/instrument/note/ranges/highest
# tree/instrument/note/ranges/highest/amplitude
# tree/instrument/note/ranges/highest/amplitude/@freqHz
# tree/instrument/note/ranges/highest/amplitude/@harmNum
# tree/instrument/note/ranges/highest/harmonicFreq
# tree/instrument/note/ranges/highest/harmonicFreq/@harmNum
# tree/instrument/note/ranges/highest/pitches
# tree/instrument/note/ranges/lowest
# tree/instrument/note/ranges/lowest/amplitude
# tree/instrument/note/ranges/lowest/amplitude/@freqHz
# tree/instrument/note/ranges/lowest/amplitude/@harmNum
# tree/instrument/note/ranges/lowest/harmonicFreq
# tree/instrument/note/ranges/lowest/harmonicFreq/@harmNum
# tree/instrument/ranges
# tree/instrument/ranges/highest
# tree/instrument/ranges/highest/amplitude
# tree/instrument/ranges/highest/amplitude/@freqHz
# tree/instrument/ranges/highest/amplitude/@fundHz
# tree/instrument/ranges/highest/amplitude/@harmNum
# tree/instrument/ranges/highest/amplitude/@keyNum
# tree/instrument/ranges/highest/amplitude/@pitch
# tree/instrument/ranges/highest/harmonicFreq
# tree/instrument/ranges/highest/harmonicFreq/@harmNum
# tree/instrument/ranges/highest/harmonicFreq/@keyNum
# tree/instrument/ranges/highest/harmonicFreq/@pitch
# tree/instrument/ranges/highest/pitch
# tree/instrument/ranges/highest/pitch/@fundHz
# tree/instrument/ranges/highest/pitch/@keyNum
# tree/instrument/ranges/lowest
# tree/instrument/ranges/lowest/amplitude
# tree/instrument/ranges/lowest/amplitude/@freqHz
# tree/instrument/ranges/lowest/amplitude/@fundHz
# tree/instrument/ranges/lowest/amplitude/@harmNum
# tree/instrument/ranges/lowest/amplitude/@keyNum
# tree/instrument/ranges/lowest/amplitude/@pitch
# tree/instrument/ranges/lowest/harmonicFreq
# tree/instrument/ranges/lowest/harmonicFreq/@harmNum
# tree/instrument/ranges/lowest/harmonicFreq/@keyNum
# tree/instrument/ranges/lowest/harmonicFreq/@pitch
# tree/instrument/ranges/lowest/pitch
# tree/instrument/ranges/lowest/pitch/@fundHz
# tree/instrument/ranges/lowest/pitch/@keyNum
# tree/instrument/ranges/pitches
# tree/ranges
# tree/ranges/highest
# tree/ranges/highest/amplitude
# tree/ranges/highest/amplitude/@freqHz
# tree/ranges/highest/amplitude/@fundHz
# tree/ranges/highest/amplitude/@harmNum
# tree/ranges/highest/amplitude/@instId
# tree/ranges/highest/amplitude/@keyNum
# tree/ranges/highest/amplitude/@name
# tree/ranges/highest/amplitude/@pitch
# tree/ranges/highest/harmonicFreq
# tree/ranges/highest/harmonicFreq/@harmNum
# tree/ranges/highest/harmonicFreq/@instId
# tree/ranges/highest/harmonicFreq/@keyNum
# tree/ranges/highest/harmonicFreq/@name
# tree/ranges/highest/harmonicFreq/@pitch
# tree/ranges/highest/pitch
# tree/ranges/highest/pitch/@fundHz
# tree/ranges/highest/pitch/@instId
# tree/ranges/highest/pitch/@keyNum
# tree/ranges/highest/pitch/@name
# tree/ranges/instruments
# tree/ranges/lowest
# tree/ranges/lowest/amplitude
# tree/ranges/lowest/amplitude/@freqHz
# tree/ranges/lowest/amplitude/@fundHz
# tree/ranges/lowest/amplitude/@harmNum
# tree/ranges/lowest/amplitude/@instId
# tree/ranges/lowest/amplitude/@keyNum
# tree/ranges/lowest/amplitude/@name
# tree/ranges/lowest/amplitude/@pitch
# tree/ranges/lowest/harmonicFreq
# tree/ranges/lowest/harmonicFreq/@harmNum
# tree/ranges/lowest/harmonicFreq/@instId
# tree/ranges/lowest/harmonicFreq/@keyNum
# tree/ranges/lowest/harmonicFreq/@name
# tree/ranges/lowest/harmonicFreq/@pitch
# tree/ranges/lowest/pitch
# tree/ranges/lowest/pitch/@fundHz
# tree/ranges/lowest/pitch/@instId
# tree/ranges/lowest/pitch/@keyNum
# tree/ranges/lowest/pitch/@name
# 
