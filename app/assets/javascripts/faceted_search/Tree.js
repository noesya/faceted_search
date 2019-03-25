/*global window, document, $ */

window.facetedSearch = window.facetedSearch || {};

window.facetedSearch.Tree = function Tree(wrapper) {
    "use strict";
    this.wrapper = wrapper;
    this.data = [];
};

window.facetedSearch.Tree.prototype.unflatten = function (list) {
    "use strict";
    var map = {},
        node,
        roots = [],
        i;

    for (i = 0; i < list.length; i += 1) {
        map[list[i].id] = i;
        list[i].children = [];
    }

    for (i = 0; i < list.length; i += 1) {
        node = list[i];
        if (node.parentId !== 0) {
            list[map[node.parentId]].children.push(node);
        } else {
            roots.push(node);
        }
    }

    return roots;
};

window.facetedSearch.Tree.prototype.generateItem = function (item) {
    "use strict";

    var liNode = document.createElement('li');

    liNode.className = item.selected ? "dd-item dd-item--selected"
                                     : "dd-item";

    var aNode = document.createElement('a');
    aNode.setAttribute("href", item.url);
    aNode.textContent = item.title;

    liNode.appendChild(aNode);

    if (item.children.length > 0) {
        var olNode = this.generateList(item.children);
        liNode.appendChild(olNode);
    }

    return liNode;
};

window.facetedSearch.Tree.prototype.generateList = function (array) {
    "use strict";

    var olNode = document.createElement('ol'),
        liNode,
        i;

    olNode.className = "faceted__facet__filter--tree__level dd-list";

    for (i = 0; i < array.length; i += 1) {
        liNode = this.generateItem(array[i]);
        olNode.appendChild(liNode);
    }

    return olNode;
};

window.facetedSearch.Tree.prototype.initDOM = function () {
    "use strict";

    var listElements = Array.prototype.slice.call(this.wrapper.querySelectorAll('li'));
    var listData = listElements.map(function (elt) {
        return {
            id: parseInt(elt.getAttribute('data-id'), 10),
            parentId: parseInt(elt.getAttribute('data-parent'), 10),
            selected: elt.getAttribute('data-selected') === "true",
            resultsCount: parseInt(elt.getAttribute('data-count'), 10),
            url: elt.getAttribute('data-url'),
            title: elt.textContent.trim()
        };
    });

    this.data = this.unflatten(listData);
    var treeNode = this.generateList(this.data);

    var rootElt = document.createElement('div');
    rootElt.className = 'dd';
    rootElt.appendChild(treeNode);

    while (this.wrapper.firstChild) {
        this.wrapper.removeChild(this.wrapper.firstChild);
    }
    this.wrapper.appendChild(rootElt);
};

window.facetedSearch.Tree.prototype.initNestable = function () {
    "use strict";

    $('.dd', this.wrapper).nestable({
        expandBtnHTML: '<button class="dd-expand-btn" data-action="expand" type="button"><i class="fas fa-folder"></i></button>',
        collapseBtnHTML: '<button class="dd-collapse-btn" data-action="collapse" type="button"><i class="fas fa-folder-open"></i></button>'
    }).data("nestable").collapseAll();
};

window.addEventListener('DOMContentLoaded', function () {
    "use strict";
    var facetedTreeElts = document.querySelectorAll('.faceted__facet__filter--tree'),
        facetedTree,
        i;

    for (i = 0; i < facetedTreeElts.length; i += 1) {
        facetedTree = new window.facetedSearch.Tree(facetedTreeElts[i]);
        facetedTree.initDOM();
        facetedTree.initNestable();
    }
});