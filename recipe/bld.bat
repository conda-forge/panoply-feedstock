mkdir "%PREFIX%"\lib
mkdir "%PREFIX%"\lib\java
mkdir "%PREFIX%"\lib\java\PanoplyJ
mkdir "%SCRIPTS%"\
xcopy "%SRC_DIR%\*" "%PREFIX%\lib\java\PanoplyJ\" /s /e

echo java -Xms512m -Xmx4g %JAVA_OPTS% -cp %PREFIX%\lib\java\PanoplyJ\jars\Panoply.jar gov.nasa.giss.panoply.Panoply   %%* > "%SCRIPTS%\panoply.bat"
echo java -Xms512m -Xmx4g %JAVA_OPTS% -cp %PREFIX%\lib\java\PanoplyJ\jars\Panoply.jar gov.nasa.giss.panoply.PanoplyCL %%* > "%SCRIPTS%\panoplycl.bat"
REM netcdf-java tools included with Panoply bundle
REM echo java -Xms512m -Xmx4g %JAVA_OPTS% -cp %PREFIX%\lib\java\PanoplyJ\jars\Panoply.jar ucar.nc2.ui.ToolsUI                         %%* > "%SCRIPTS%\ncj-toolsui.bat"
echo java -Xms512m -Xmx4g %JAVA_OPTS% -cp %PREFIX%\lib\java\PanoplyJ\jars\Panoply.jar ucar.nc2.write.Nccopy                       %%* > "%SCRIPTS%\ncj-nccopy.bat"
echo java -Xms512m -Xmx4g %JAVA_OPTS% -cp %PREFIX%\lib\java\PanoplyJ\jars\Panoply.jar ucar.nc2.NCdumpW                            %%* > "%SCRIPTS%\ncj-ncdump.bat"
echo java -Xms512m -Xmx4g %JAVA_OPTS% -cp %PREFIX%\lib\java\PanoplyJ\jars\Panoply.jar ucar.nc2.util.CompareNetcdf2                %%* > "%SCRIPTS%\ncj-nccompare.bat"
echo java -Xms512m -Xmx4g %JAVA_OPTS% -cp %PREFIX%\lib\java\PanoplyJ\jars\Panoply.jar ucar.nc2.iosp.bufr.writer.BufrSplitter      %%* > "%SCRIPTS%\ncj-bufrspliter.bat"
echo java -Xms512m -Xmx4g %JAVA_OPTS% -cp %PREFIX%\lib\java\PanoplyJ\jars\Panoply.jar ucar.nc2.ft.point.writer.CFPointWriter      %%* > "%SCRIPTS%\ncj-cfpointwriter.bat"
echo java -Xms512m -Xmx4g %JAVA_OPTS% -cp %PREFIX%\lib\java\PanoplyJ\jars\Panoply.jar ucar.nc2.grib.collection.GribCdmIndex       %%* > "%SCRIPTS%\ncj-gribcdmindex.bat"
echo java -Xms512m -Xmx4g %JAVA_OPTS% -cp %PREFIX%\lib\java\PanoplyJ\jars\Panoply.jar ucar.nc2.ft2.scan.FeatureScan               %%* > "%SCRIPTS%\ncj-featurescan.bat"
echo java -Xms512m -Xmx4g %JAVA_OPTS% -cp %PREFIX%\lib\java\PanoplyJ\jars\Panoply.jar thredds.client.catalog.tools.CatalogCrawler %%* > "%SCRIPTS%\ncj-catalogcrawler.bat"
