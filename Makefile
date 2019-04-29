clean:
	rm -rf build/ dist/ *.egg-info

dist: setup.py requests_random_user_agent/__init__.py
	pipenv run python setup.py sdist

upload: dist
	pipenv run python -m twine upload dist/*

test:
	pipenv run python -m unittest discover tests/

# Must do this in two separate steps otherwise the random agent selection
# used in the scraper will fail because the useragents.txt file is empty
scrape:
	PYTHONPATH=. pipenv run scripts/scrape.py | sort | sed '/^$$/d' > useragents.txt
	mv useragents.txt requests_random_user_agent/

.PHONY: clean upload test scrape
