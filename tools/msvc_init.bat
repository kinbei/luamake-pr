@echo off

mkdir build\msvc 2>nul
cd build\msvc

mkdir temp 2>nul
type nul>temp/test.h
echo #include "test.h" >temp/test.c

cd temp
for /f "usebackq delims=: tokens=1,2 skip=1" %%G in (`cl /showIncludes /nologo test.c`) do (
  set MsvcPrefix=%%G:%%H:
  goto Break
)
:Break
cd ..
rmdir /q /s temp

echo msvc_deps_prefix = %MsvcPrefix% > init.ninja
echo subninja ninja/msvc.ninja >> init.ninja

cd ../..

@echo on
