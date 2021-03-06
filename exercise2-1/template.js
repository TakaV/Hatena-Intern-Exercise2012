var Template = function(input) {
    this.source = input.source;
};

Template.prototype.render = function(variables) {
    var template = this;
    var replaceSource = this.source.replace(/{%\s(.*)\s%}/g, function(string, part) {
        return template.escapeString(variables[part]);
    });

    return replaceSource;
};

Template.prototype.escapeString = function(string) {
    return string.replace(/[<>&"]/g, function(string) {
        var data = {
            "<" : "&lt;",
            ">" : "&gt;",
            "&" : "&amp;",
            "\"": "&quot;",
        };

        return data[string];
    });
};