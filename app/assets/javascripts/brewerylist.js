const BREWERIES = {};

BREWERIES.show = () => {
  $("#brewerytable tr:gt(0)").remove();
  const table = $("#brewerytable");

  BREWERIES.list.forEach(beer => {
    table.append(
      "<tr>" +
        "<td>" +
        beer["name"] +
        "</td>" +
        "<td>" +
        beer["year"] +
        "</td>" +
        "<td>" +
        beer["beers"] +
        "</td>" +
        "<td>" +
        beer["active"] +
        "</td>" +
        "</tr>"
    );
  });
};

BREWERIES.sort_by_name = () => {
  BREWERIES.list.sort((a, b) => {
    return a.name.toUpperCase().localeCompare(b.name.toUpperCase());
  });
};

BREWERIES.sort_by_year = () => {
  BREWERIES.list.sort((a, b) => {
    return a.year - b.year;
  });
};

BREWERIES.sort_by_count = () => {
  BREWERIES.list.sort((a, b) => {
    return a.beers - b.beers;
  });
};

BREWERIES.sort_by_active = () => {
  BREWERIES.list.sort((a, b) => {
    return a.active.toUpperCase().localeCompare(b.active.toUpperCase());
  });
};

document.addEventListener("turbolinks:load", () => {
  if ($("#brewerytable").length == 0) {
    return;
  }

  $("#name").click(e => {
    e.preventDefault();
    BREWERIES.sort_by_name();
    BREWERIES.show();
  });

  $("#year").click(e => {
    e.preventDefault();
    BREWERIES.sort_by_year();
    BREWERIES.show();
  });

  $("#count").click(e => {
    e.preventDefault();
    BREWERIES.sort_by_count();
    BREWERIES.show();
  });

  $("#active").click(e => {
    e.preventDefault();
    BREWERIES.sort_by_active();
    BREWERIES.show();
  });

  $.getJSON("breweries.json", list => {
    BREWERIES.list = list;
    BREWERIES.show();
  });
});
