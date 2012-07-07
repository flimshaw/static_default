// Generated by CoffeeScript 1.3.3
(function() {
  var _ref;

  this.app = (_ref = window.app) != null ? _ref : {};

  describe("Default", function() {
    beforeEach(function() {
      runs(function() {
        return app.Default.fetch();
      });
      waitsFor(function() {
        return app.Default.length === 3;
      });
      return runs(function() {
        return this.Default = app.Default;
      });
    });
    it("loads properly from the json file", function() {
      return expect(this.Default.models[0].get('title') === "Project 1").toBeTruthy();
    });
    it("can be searched for Default by a particular director", function() {
      expect(this.Default.byDirector('Director 1').length).toBe(2);
      expect(this.Default.byDirector('Director 1').models[0].get('video').director).toBe('Director 1');
      return expect(this.Default.byDirector('Director 1').models[1].get('video').director).toBe('Director 1');
    });
    return it("can return a list of unique directors", function() {
      this.directors = this.Default.listDirectors();
      expect(this.directors.length).toBe(2);
      expect(this.directors[0]).toBe("Director 1");
      return expect(this.directors[1]).not.toBe("Director 2");
    });
  });

}).call(this);
