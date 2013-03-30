all: quick-tour models-and-domain-logic collections-and-sync views-and-events eco-templates routers-and-history

browser-test = cd $1 && $(MAKE) && open test/index.html

quick-tour:
	$(call browser-test,02-quick-tour)

models-and-domain-logic:
	$(call browser-test,04-models-and-domain-logic)

collections-and-sync:
	$(call browser-test,05-collections-and-sync)

views-and-events:
	$(call browser-test,06-views-and-events)

eco-templates:
	$(call browser-test,07-eco-templates)

routers-and-history:
	$(call browser-test,08-routers-and-history)

.PHONY: quick-tour models-and-domain-logic collections-and-sync views-and-events eco-templates routers-and-history
