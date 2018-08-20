IF NOT "%TOOLCHAIN%"=="msvc14" (
    echo Toolchain %TOOLCHAIN% is not supported
    exit -1
)

IF "%PLATFORM%"=="x86" (
    echo Performing x86 build
    call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" x86
) ELSE (
    echo Performing amd64 build
    call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" amd64
)


