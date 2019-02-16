
build: src/*
	if moonc src; then make execute; fi

execute:
	/mnt/e/Programme/LOVE/love.exe src
