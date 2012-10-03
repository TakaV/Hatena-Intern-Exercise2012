var Template = function(input) {
    this.source = input.source;
};

Template.prototype = {
    render: function(variables) {
        var escapeString = function(string) {
            var escape = function(string) {
                var data = {
                    "<" : "&lt;",
                    ">" : "&gt;",
                    "&" : "&amp;",
                    "\"": "&quot;",
                };

                return data[string];
            };

            return string.replace(/[<>&"]/g, escape);
        };

        var accessValue = function(string, part) {
            return escapeString(variables[part]);
        };

        var replaceSource = this.source.replace(/{%\s(.*)\s%}/g, accessValue);
        return replaceSource;
    }
};