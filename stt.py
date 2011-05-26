#!/bin/python
import os
import json 
fileName = "/home/prayag/Dropbox/Secret_cloud/text.txt"

if __name__ == "__main__":
    #os.system("rm -rf ffmpeg.flac")
    os.system("ffmpeg -f oss -i /dev/dsp -ar 16000 -ab 512000 ffmpeg.flac")
    os.system("rec -r 16k ffmpeg.flac")
    cmdString = 'wget -q -U \"Mozilla/5.0\" --post-file ffmpeg.flac --header=\"Content-Type: audio/x-flac; rate=16000\" -O - \"http://www.google.com/speech-api/v1/recognize?lang=en-us&client=chromium\"'
    resultFile = os.popen(cmdString, "r") 
    resultString = resultFile.read()
    jsonObject = json.loads(resultString)
    finalText = jsonObject['hypotheses'][0]['utterance']
    f = open(fileName,"a")
    f.write("\n")
    f.write(finalText)
    f.close()
    os.system("rm -rf ffmpeg.flac")
    


