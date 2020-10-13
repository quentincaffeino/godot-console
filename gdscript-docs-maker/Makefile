all: clean build upload

build:
	python3 setup.py sdist bdist_wheel

clean:
	rm -rf ./*.egg-info
	rm -rf ./build
	rm -rf ./dist/*

upload:
	python3 -m twine upload dist/*

info:
	python3 setup.py egg_info
