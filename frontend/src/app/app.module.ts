import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import {TalksComponent} from "./talks/talks.component";
import {HttpClientModule} from "@angular/common/http";
import {Router, RouterModule, Routes} from "@angular/router";
import {ApiService} from "./api.service";
import {TalkComponent} from "./talk/talk.component";


const routes: Routes = [
  {
    path: '', component: TalksComponent
  }, {
    path: ':id', component: TalkComponent
  }
];

@NgModule({
  declarations: [
    AppComponent,
    TalksComponent,
    TalkComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    RouterModule.forRoot(routes)
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
