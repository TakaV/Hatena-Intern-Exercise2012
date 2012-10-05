var Template = (function() {

    var template = function(input) {
        this.source = input.source;
    };

    template.prototype.render = function(variables) {
        var template = this;
        var replaceSource = this.source.replace(/{%\s(.*)\s%}/g, function(string, part) {
            return template.escapeString(variables[part]);
        });

        return replaceSource;
    };

    template.prototype.escapeString = function(string) {
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
    
    return template
})();