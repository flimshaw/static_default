// Generated by CoffeeScript 1.3.3
(function() {
  var Buffer, Project, Projects, ViewContainer, setNav, _ref, _ref1, _ref2, _ref3, _ref4, _ref5,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  this.app = (_ref = window.app) != null ? _ref : {};

  Project = (function(_super) {

    __extends(Project, _super);

    function Project() {
      return Project.__super__.constructor.apply(this, arguments);
    }

    return Project;

  })(Backbone.Model);

  this.app.Project = Project;

  this.app = (_ref1 = window.app) != null ? _ref1 : {};

  Projects = (function(_super) {

    __extends(Projects, _super);

    function Projects() {
      return Projects.__super__.constructor.apply(this, arguments);
    }

    Projects.prototype.model = app.Project;

    Projects.prototype.url = '/projects';

    Projects.prototype.byDirector = function(director) {
      var dirProjects;
      dirProjects = this.filter(function(project) {
        return project.get('video').director === director;
      });
      return this.reset(dirProjects);
    };

    Projects.prototype.listDirectors = function() {
      var _this = this;
      this.directors = [];
      this.each(function(project) {
        return _this.directors.push(project.get('video').director);
      });
      return _.uniq(this.directors);
    };

    return Projects;

  })(Backbone.Collection);

  this.app.Projects = new Projects;

  this.app = (_ref2 = window.app) != null ? _ref2 : {};

  jQuery(function() {
    var DirectorListView, DirectorProjectsView, DirectorView, NavView, ProjectView, ProjectsView, TestView;
    NavView = (function(_super) {

      __extends(NavView, _super);

      function NavView() {
        return NavView.__super__.constructor.apply(this, arguments);
      }

      NavView.prototype.initialize = function() {
        return this.template = _.template($("#nav_template").html());
      };

      NavView.prototype.render = function() {
        var renderedContent;
        renderedContent = this.template();
        $(this.el).html(renderedContent);
        return this;
      };

      return NavView;

    })(Backbone.View);
    TestView = (function(_super) {

      __extends(TestView, _super);

      function TestView() {
        return TestView.__super__.constructor.apply(this, arguments);
      }

      TestView.prototype.initialize = function() {
        return this.template = _.template($("#test_template").html());
      };

      TestView.prototype.render = function() {
        var renderedContent;
        renderedContent = this.template();
        return $(this.el).html(renderedContent);
      };

      return TestView;

    })(Backbone.View);
    ProjectView = (function(_super) {

      __extends(ProjectView, _super);

      function ProjectView() {
        return ProjectView.__super__.constructor.apply(this, arguments);
      }

      ProjectView.prototype.tagName = 'li';

      ProjectView.prototype.initialize = function() {
        this.template = _.template($("#project_template").html());
        return this.model.bind('change', this.render, this);
      };

      ProjectView.prototype.render = function() {
        var renderedContent;
        renderedContent = this.template(this.model.toJSON());
        $(this.el).html(renderedContent);
        return this;
      };

      return ProjectView;

    })(Backbone.View);
    ProjectsView = (function(_super) {

      __extends(ProjectsView, _super);

      function ProjectsView() {
        return ProjectsView.__super__.constructor.apply(this, arguments);
      }

      ProjectsView.prototype.tagName = 'div';

      ProjectsView.prototype.className = 'projects';

      ProjectsView.prototype.initialize = function() {
        this.template = _.template($('#projects_template').html());
        return this.collection.bind('reset', this.render, this);
      };

      ProjectsView.prototype.render = function() {
        var $projects,
          _this = this;
        $(this.el).html(this.template({}));
        $projects = this.$('.projects');
        this.collection.each(function(project) {
          var view;
          view = new ProjectView({
            model: project,
            collection: _this.collection
          });
          return $projects.append(view.render().el);
        });
        return this;
      };

      return ProjectsView;

    })(Backbone.View);
    DirectorProjectsView = (function(_super) {

      __extends(DirectorProjectsView, _super);

      function DirectorProjectsView() {
        return DirectorProjectsView.__super__.constructor.apply(this, arguments);
      }

      return DirectorProjectsView;

    })(ProjectsView);
    DirectorView = (function(_super) {

      __extends(DirectorView, _super);

      function DirectorView() {
        return DirectorView.__super__.constructor.apply(this, arguments);
      }

      DirectorView.prototype.initialize = function() {
        return this.template = _.template($("#director_template").html());
      };

      return DirectorView;

    })(ProjectView);
    DirectorListView = (function(_super) {

      __extends(DirectorListView, _super);

      function DirectorListView() {
        return DirectorListView.__super__.constructor.apply(this, arguments);
      }

      DirectorListView.prototype.tagName = 'section';

      DirectorListView.prototype.className = 'directors';

      DirectorListView.prototype.initialize = function() {
        this.template = _.template($('#directorList_template').html());
        return this.collection.bind('reset', this.render, this);
      };

      DirectorListView.prototype.render = function() {
        var $directorList,
          _this = this;
        $(this.el).html(this.template({}));
        $directorList = this.$('.directors');
        _.each(this.collection.listDirectors(), function(director) {
          var model, view;
          model = new Backbone.Model({
            director: director
          });
          view = new DirectorView({
            model: model,
            collection: _this.collection
          });
          return $directorList.append(view.render().el);
        });
        return this;
      };

      return DirectorListView;

    })(Backbone.View);
    app.TestView = TestView;
    app.ProjectsView = ProjectsView;
    app.ProjectView = ProjectView;
    app.DirectorView = DirectorView;
    app.DirectorListView = DirectorListView;
    return app.NavView = NavView;
  });

  this.app = (_ref3 = window.app) != null ? _ref3 : {};

  setNav = function(id) {
    $("header nav .onState").removeClass("onState");
    return $(id).addClass("onState");
  };

  Buffer = (function() {

    function Buffer() {
      this.add = __bind(this.add, this);

    }

    Buffer.prototype.commands = [];

    Buffer.prototype.add = function(fn) {
      var next,
        _this = this;
      next = function() {
        _this.commands.shift();
        if (_this.commands.length) {
          return _this.commands[0](next);
        }
      };
      this.commands.push(fn);
      if (this.commands.length === 1) {
        fn(next);
      }
      return this.commands.length;
    };

    return Buffer;

  })();

  ViewContainer = (function() {

    ViewContainer.prototype.animateOutType = "bounceOutLeft";

    ViewContainer.prototype.animateInType = "bounceInLeft";

    function ViewContainer(targetDiv) {
      this.animate = __bind(this.animate, this);
      this.contentBuffer = new Buffer();
      _.extend(this, Backbone.Events);
      this.$targetDiv = targetDiv;
      this.$targetDiv.addClass('animated');
    }

    ViewContainer.prototype.run = function(fn) {
      return this.contentBuffer.add(fn);
    };

    ViewContainer.prototype.bufferLength = function() {
      return this.contentBuffer.commands.length;
    };

    ViewContainer.prototype.animate = function(callback) {
      var _this = this;
      this.callback = callback;
      this.$targetDiv.addClass(this.animateOutType);
      return this.$targetDiv.bind('webkitAnimationEnd', function(e) {
        _this.$targetDiv.empty();
        _this.$targetDiv.unbind('webkitAnimationEnd');
        _this.$targetDiv.html(_this.newView.render());
        _this.$targetDiv.removeClass(_this.animateOutType);
        _this.$targetDiv.addClass(_this.animateInType);
        return _this.$targetDiv.bind('webkitAnimationEnd', _this.callback);
      });
    };

    ViewContainer.prototype.load = function(view) {
      var fn,
        _this = this;
      this.newView = view;
      fn = function(next) {
        return _this.animate(next);
      };
      return this.run(fn);
    };

    return ViewContainer;

  })();

  this.app.ViewContainer = ViewContainer;

  this.app.setNav = setNav;

  this.app = (_ref4 = window.app) != null ? _ref4 : {};

  jQuery(function() {
    var ProjectsRouter;
    ProjectsRouter = (function(_super) {

      __extends(ProjectsRouter, _super);

      function ProjectsRouter() {
        return ProjectsRouter.__super__.constructor.apply(this, arguments);
      }

      ProjectsRouter.prototype.routes = {
        '': 'home',
        'blank': 'blank',
        'directors': 'directors',
        'director/:directorName': 'director',
        'animation': 'animation',
        'entertainment': 'entertainment',
        'about': 'about'
      };

      ProjectsRouter.prototype.initialize = function() {
        this.$container = $('#container');
        this.nav = new app.NavView();
        return $("header nav").html(this.nav.render().el);
      };

      ProjectsRouter.prototype.home = function() {
        this.$container.empty();
        this.view = new app.ProjectsView({
          collection: app.Projects
        });
        this.$container.html(this.view.render().el);
        return app.setNav('');
      };

      ProjectsRouter.prototype.directors = function() {
        this.directorListView = new app.DirectorListView({
          collection: app.Projects
        });
        this.$container.empty();
        this.$container.append(this.directorListView.render().el);
        return app.setNav('#directors');
      };

      ProjectsRouter.prototype.director = function(directorName) {
        this.$container.empty();
        this.$container.append(directorName);
        return app.setNav('#directors');
      };

      ProjectsRouter.prototype.animation = function() {
        this.$container.empty();
        this.$container.text('animation!');
        return app.setNav('#animation');
      };

      ProjectsRouter.prototype.entertainment = function() {
        this.$container.empty();
        this.$container.text('entertainment!');
        return app.setNav('#entertainment');
      };

      ProjectsRouter.prototype.about = function() {
        this.$container.empty();
        this.$container.text('about!');
        return app.setNav('#about');
      };

      return ProjectsRouter;

    })(Backbone.Router);
    return app.ProjectsRouter = ProjectsRouter;
  });

  this.app = (_ref5 = window.app) != null ? _ref5 : {};

  jQuery(function() {
    app.Projects.fetch();
    app.router = new app.ProjectsRouter();
    app.router.on("route", function() {
      return console.log("routed.");
    });
    Backbone.history.start();
    return console.log("Backbone loaded.");
  });

}).call(this);