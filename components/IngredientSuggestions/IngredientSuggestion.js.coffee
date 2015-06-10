# The sub-component <IngredientSuggestion/>

@IngredientSuggestion = React.createClass
  mixins: [Fluxxor.FluxMixin(React)]

  getInitialState: ->
    saved_value: @props.ingredient.name
    value:       @props.ingredient.name
    changed:     false
    updated:     false

  handleChange: ->
    input = @refs.input.getValue()
    if input is @state.saved_value
      @setState(value: input, changed: false, updated: false)
    else
      @setState(value: input, changed: true, updated: false)

  handleUpdate: (e) ->
    e.preventDefault()
    input = @refs.input.getValue()
    @getFlux().actions.updateIngredient(@props.ingredient, input)
    @setState(changed: false, updated: true, saved_value: input)

  handleDelete: (e) ->
    e.preventDefault()
    if confirm("Delete " + @props.ingredient.name + "?")
      @getFlux().actions.deleteIngredient(@props.ingredient)

  handleCancelChange: (e) ->
    e.preventDefault()
    @setState(value: @state.saved_value, changed: false)

  render: ->
    ButtonToolbar = ReactBootstrap.ButtonToolbar
    Button = ReactBootstrap.Button
    Input = ReactBootstrap.Input

    delete_button =
      <Button onClick={@handleDelete}>
        <i className="fa fa-times"></i>
      </Button>

    update_button =
      <div>
        <a onClick={@handleUpdate}       >Update</a>
        &nbsp; | &nbsp;
        <a onClick={@handleCancelChange} >Cancel</a>
      </div>

    <form>
      <Input type='text'
             onChange={@handleChange}
             ref='input'
             value={@state.value}
             buttonBefore={ delete_button }
             addonAfter={update_button if @state.changed}
             bsStyle={'success' if @state.updated} />
    </form>
