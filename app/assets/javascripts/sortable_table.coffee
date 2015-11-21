class OttawaURSSP.SortableTable
  constructor: (@table_selector) ->
    $(@table_selector).tablesorter()
