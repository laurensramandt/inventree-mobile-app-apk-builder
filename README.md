InvenTree Android Build Dockerfile
==================================

This repository provides a Dockerfile to automate the build process for the InvenTree Android app, resulting in an APK file placed in the output directory.

Requirements
------------

*   Docker installed
    

Usage
-----

1.  mkdir -p ./output
    
2.  docker build -t inventree-dockerbuild .
    
3.  docker run -v $(pwd)/output:/output -ti --rm inventree-dockerbuild
    

Output
------

*   The generated APK file will be available in the output subdirectory.
    

Notes
-----

*   The Dockerfile clones the InvenTree Android app source and compiles it.   
    
*   The output directory is mapped to extract the generated APK from the container.
    

Troubleshooting
---------------

*   Ensure adequate disk space and correct dependency versions.
    
*   Run docker logs for build errors.
    

License
-------

Licensed under the MIT License. See the LICENSE file for more information.