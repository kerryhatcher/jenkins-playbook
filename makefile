.PHONY: run clean

VENV = venv
PYTHON = $(VENV)/bin/python3
PIP = $(VENV)/bin/pip


$(VENV)/bin/activate: requirements.txt
	python3 -m venv $(VENV)
	$(PIP) install -r requirements.txt

run: $(VENV)/bin/activate
	$(PYTHON) app.py

lint: $(VENV)/bin/activate
	$(VENV)/bin/yamllint .
	$(VENV)/bin/ansible-lint

clean:
	rm -rf __pycache__
	rm -rf $(VENV)