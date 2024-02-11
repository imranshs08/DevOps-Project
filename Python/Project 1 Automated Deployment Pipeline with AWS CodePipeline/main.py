class Tools:
    name_car = []
    tyres = 4
    brand="toyota"
    def carTyres(self):
        if self.tyres == 4:
            self.name_car.append(self.brand)
            print(self.name_car)
        else:
            print("No 4 wheelers car in the list")
Toyota = Tools()
Toyota.carTyres()