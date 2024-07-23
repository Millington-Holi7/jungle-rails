describe("Product Page", () => {
  it("should visit the home page", () => {
    cy.visit("/");
  });

  it("There is products on the page", () => {
    cy.visit("/");
    cy.get(".products article").should("be.visible");
  });

  it("There is 2 products on the page", () => {
    cy.visit("/");
    cy.get(".products article").should("have.length", 2);
  });

  it('Users can navigate from the home page to the product detail page by clicking on a product', () => {
    cy.visit("/");
    cy.get(".products article").should("have.length", 2);
    cy.get(".products article").first().find('a').click();

  });
});
