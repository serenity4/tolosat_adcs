# Cleans (removes) slprj folders created by Simulink. They are really annoying.

rm -rf $(find ../.. -maxdepth 16 -type d | grep slprj)
