/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).on('turbolinks:load', function() {
    $( "#search" ).autocomplete({
      source: "/search_suggestions"
    });
  } );