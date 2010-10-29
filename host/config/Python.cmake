#
# Copyright 2010 Ettus Research LLC
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

########################################################################
# Setup Python
########################################################################
INCLUDE(FindPythonInterp)

IF(NOT PYTHONINTERP_FOUND)
    MESSAGE(FATAL_ERROR "Error: Python interpretor required by the build system.")
ENDIF(NOT PYTHONINTERP_FOUND)

MACRO(PYTHON_CHECK_MODULE desc mod cmd have)
    MESSAGE(STATUS "Python checking for ${desc}")
    EXECUTE_PROCESS(
        COMMAND ${PYTHON_EXECUTABLE} -c "
#########################################
try: import ${mod}
except: exit(-1)
try: assert ${cmd}
except: exit(-1)
#########################################"
        RESULT_VARIABLE ${have}
    )
    IF(${have} EQUAL 0)
        MESSAGE(STATUS "Python checking for ${desc} - found")
        SET(${have} TRUE)
    ELSE(${have} EQUAL 0)
        MESSAGE(STATUS "Python checking for ${desc} - not found")
        SET(${have} FALSE)
    ENDIF(${have} EQUAL 0)
ENDMACRO(PYTHON_CHECK_MODULE)
