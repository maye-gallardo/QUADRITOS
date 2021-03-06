Given("visito la pagina mejores puntajes") do
    visit('/scores')
end
  
Then("deberia ver el nombre jugador") do
    expect(page).to have_content("GoDiegoGo")
end
  
Then("deberia ver el enlace {string} para voler a la pagina principal") do |string|
    expect(page).to have_content(string)
end
  
Then("deberia ver una tabla con el titulo {string}") do |string|
    expect(page).to have_content(string)
end

Then("se ve la columna {string}") do |string|
    expect(page).to have_content(string)
end