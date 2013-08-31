SET TmpListFn=tmpFileList.txt
SET TreadCnt=4
SET OutVideoFn=YourDVDVideo
SET OutVideoExt=avi
SET OutTmpDir=tmp

DEL %TmpListFn%.txt
MD %OutTmpDir%
FOR %%c in (*.VOB) DO (
ffmpeg -threads %TreadCnt% -deinterlace -i %%c -vcodec libx264 -y %%c.%OutVideoExt%
echo file %%c.%OutVideoExt% >> %TmpListFn%
)
ffmpeg  -f concat -i %TmpListFn% -c copy -y %OutTmpDir%\%OutVideoFn%.%OutVideoExt%
DEL *.%OutVideoExt%
MOVE %OutTmpDir%\%OutVideoFn%.%OutVideoExt% %OutVideoFn%.%OutVideoExt%
RMDIR %OutTmpDir%
DEL %TmpListFn%